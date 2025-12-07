/**
 * Camera utilities for client-side camera access and frame capture
 */

class CameraUtils {
    constructor() {
        this.stream = null;
        this.video = null;
    }

    /**
     * Initialize camera access
     * @param {HTMLVideoElement} videoElement - Video element to display camera feed
     * @returns {Promise<MediaStream>} Camera stream
     */
    async initCamera(videoElement) {
        try {
            this.video = videoElement;
            this.stream = await navigator.mediaDevices.getUserMedia({ 
                video: { 
                    width: { ideal: 640 },
                    height: { ideal: 480 },
                    facingMode: 'user'
                } 
            });
            
            this.video.srcObject = this.stream;
            return this.stream;
        } catch (error) {
            console.error('Error accessing camera:', error);
            throw new Error('Tidak dapat mengakses kamera. Pastikan izin kamera diberikan.');
        }
    }

    /**
     * Stop camera stream
     */
    stopCamera() {
        if (this.stream) {
            const tracks = this.stream.getTracks();
            tracks.forEach(track => track.stop());
            this.stream = null;
        }
        
        if (this.video) {
            this.video.srcObject = null;
        }
    }

    /**
     * Capture current frame from video
     * @returns {string} Base64 encoded image data
     */
    captureFrame() {
        if (!this.video || !this.video.videoWidth || !this.video.videoHeight) {
            throw new Error('Video not ready');
        }

        const canvas = document.createElement('canvas');
        canvas.width = this.video.videoWidth;
        canvas.height = this.video.videoHeight;
        
        const ctx = canvas.getContext('2d');
        ctx.drawImage(this.video, 0, 0);
        
        return canvas.toDataURL('image/jpeg', 0.8);
    }

    /**
     * Check if video is ready for capture
     * @returns {boolean} True if video is ready
     */
    isVideoReady() {
        return this.video && this.video.videoWidth > 0 && this.video.videoHeight > 0;
    }
}

/**
 * Gesture detection utilities
 */
class GestureDetector {
    constructor(cameraUtils) {
        this.camera = cameraUtils;
        this.isDetecting = false;
        this.detectionInterval = null;
        this.onDetection = null;
        this.detectionType = 'alphabet'; // 'alphabet' or 'vocabulary'
    }

    /**
     * Start real-time gesture detection
     * @param {Function} callback - Callback function for detection results
     * @param {string} type - Detection type ('alphabet' or 'vocabulary')
     * @param {number} interval - Detection interval in milliseconds
     */
    startDetection(callback, type = 'alphabet', interval = 500) {
        this.onDetection = callback;
        this.detectionType = type;
        this.isDetecting = true;

        this.detectionInterval = setInterval(async () => {
            if (!this.isDetecting) return;

            try {
                if (!this.camera.isVideoReady()) {
                    return;
                }

                const imageData = this.camera.captureFrame();
                const detections = await this.detectGesture(imageData, type);
                
                if (this.onDetection) {
                    this.onDetection(detections);
                }
            } catch (error) {
                console.error('Detection error:', error);
            }
        }, interval);
    }

    /**
     * Stop gesture detection
     */
    stopDetection() {
        this.isDetecting = false;
        if (this.detectionInterval) {
            clearInterval(this.detectionInterval);
            this.detectionInterval = null;
        }
    }

    /**
     * Send image to server for gesture detection
     * @param {string} imageData - Base64 encoded image
     * @param {string} type - Detection type
     * @returns {Promise<Array>} Detection results
     */
    async detectGesture(imageData, type = 'alphabet') {
        const response = await fetch('/detect_gesture', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ image: imageData, type: type })
        });

        const result = await response.json();
        
        if (result.success && result.detections.length > 0) {
            return result.detections;
        }
        
        return [];
    }
}

/**
 * Hold timer for gesture validation
 */
class HoldTimer {
    constructor(requiredTime = 3000, threshold = 0.8) {
        this.requiredTime = requiredTime;
        this.threshold = threshold;
        this.startTime = null;
        this.currentGesture = null;
        this.onProgress = null;
        this.onComplete = null;
    }

    /**
     * Process detection and update hold timer
     * @param {Array} detections - Detection results
     * @param {string} targetGesture - Target gesture to match
     */
    processDetection(detections, targetGesture) {
        if (detections.length === 0) {
            this.reset();
            return;
        }

        const bestDetection = detections.reduce((best, current) => 
            current.confidence > best.confidence ? current : best
        );

        const { class: detectedClass, confidence } = bestDetection;

        if (detectedClass === targetGesture && confidence >= this.threshold) {
            if (!this.startTime) {
                this.startTime = Date.now();
                this.currentGesture = detectedClass;
            }

            const elapsed = Date.now() - this.startTime;
            const progress = Math.min((elapsed / this.requiredTime) * 100, 100);

            if (this.onProgress) {
                this.onProgress(progress, elapsed, detectedClass, confidence);
            }

            if (elapsed >= this.requiredTime) {
                if (this.onComplete) {
                    this.onComplete(detectedClass, confidence);
                }
                this.reset();
            }
        } else {
            this.reset();
        }
    }

    /**
     * Reset hold timer
     */
    reset() {
        this.startTime = null;
        this.currentGesture = null;
        
        if (this.onProgress) {
            this.onProgress(0, 0, null, 0);
        }
    }

    /**
     * Set progress callback
     * @param {Function} callback - Progress callback function
     */
    setProgressCallback(callback) {
        this.onProgress = callback;
    }

    /**
     * Set completion callback
     * @param {Function} callback - Completion callback function
     */
    setCompletionCallback(callback) {
        this.onComplete = callback;
    }
}

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { CameraUtils, GestureDetector, HoldTimer };
} else {
    window.CameraUtils = CameraUtils;
    window.GestureDetector = GestureDetector;
    window.HoldTimer = HoldTimer;
}