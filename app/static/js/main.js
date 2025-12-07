// BISINDO Learning Platform - Main JavaScript

// Global variables
let currentUser = null;
let detectionActive = false;

// Initialize application
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
    setupEventListeners();
    loadUserData();
});

// Initialize application
function initializeApp() {
    console.log('BISINDO Learning Platform initialized');
    
    // Add fade-in animation to cards
    const cards = document.querySelectorAll('.card');
    cards.forEach((card, index) => {
        setTimeout(() => {
            card.classList.add('fade-in-up');
        }, index * 100);
    });
    
    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// Setup event listeners
function setupEventListeners() {
    // Navigation active state
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
    
    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
    
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    // Form validation
    const forms = document.querySelectorAll('.needs-validation');
    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });
}

// Load user data
function loadUserData() {
    // This would typically fetch data from the server
    const userData = localStorage.getItem('bisindo_user');
    if (userData) {
        currentUser = JSON.parse(userData);
        updateUserInterface();
    }
}

// Update user interface based on user data
function updateUserInterface() {
    if (currentUser) {
        // Update user-specific elements
        const userElements = document.querySelectorAll('.user-name');
        userElements.forEach(element => {
            element.textContent = currentUser.username;
        });
    }
}

// Camera and Detection Functions
class CameraDetection {
    constructor() {
        this.video = null;
        this.canvas = null;
        this.context = null;
        this.stream = null;
        this.isActive = false;
    }
    
    async startCamera() {
        try {
            this.stream = await navigator.mediaDevices.getUserMedia({ 
                video: { width: 640, height: 480 } 
            });
            
            if (this.video) {
                this.video.srcObject = this.stream;
                this.isActive = true;
                return true;
            }
        } catch (error) {
            console.error('Error accessing camera:', error);
            showNotification('Tidak dapat mengakses kamera', 'error');
            return false;
        }
    }
    
    stopCamera() {
        if (this.stream) {
            this.stream.getTracks().forEach(track => track.stop());
            this.stream = null;
            this.isActive = false;
        }
        
        if (this.video) {
            this.video.srcObject = null;
        }
    }
    
    captureFrame() {
        if (!this.video || !this.canvas) return null;
        
        this.context.drawImage(this.video, 0, 0, this.canvas.width, this.canvas.height);
        return this.canvas.toDataURL('image/jpeg');
    }
}

// Initialize camera detection
const cameraDetection = new CameraDetection();

// Gesture detection function
async function detectGesture(imageData) {
    try {
        const response = await fetch('/detect_gesture', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                image: imageData
            })
        });
        
        const result = await response.json();
        return result;
    } catch (error) {
        console.error('Error detecting gesture:', error);
        return { success: false, error: error.message };
    }
}

// Notification system
function showNotification(message, type = 'info', duration = 3000) {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    
    notification.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    document.body.appendChild(notification);
    
    // Auto remove after duration
    setTimeout(() => {
        if (notification.parentNode) {
            notification.remove();
        }
    }, duration);
}

// Progress tracking
class ProgressTracker {
    constructor() {
        this.progress = this.loadProgress();
    }
    
    loadProgress() {
        const saved = localStorage.getItem('bisindo_progress');
        return saved ? JSON.parse(saved) : {
            alphabetProgress: {},
            vocabularyProgress: {},
            practiceHistory: [],
            achievements: []
        };
    }
    
    saveProgress() {
        localStorage.setItem('bisindo_progress', JSON.stringify(this.progress));
    }
    
    updateAlphabetProgress(letter, accuracy) {
        this.progress.alphabetProgress[letter] = {
            accuracy: accuracy,
            attempts: (this.progress.alphabetProgress[letter]?.attempts || 0) + 1,
            lastPracticed: new Date().toISOString()
        };
        this.saveProgress();
    }
    
    updateVocabularyProgress(word, accuracy) {
        this.progress.vocabularyProgress[word] = {
            accuracy: accuracy,
            attempts: (this.progress.vocabularyProgress[word]?.attempts || 0) + 1,
            lastPracticed: new Date().toISOString()
        };
        this.saveProgress();
    }
    
    addPracticeRecord(type, target, accuracy) {
        this.progress.practiceHistory.unshift({
            date: new Date().toISOString(),
            type: type,
            target: target,
            accuracy: accuracy,
            status: accuracy >= 80 ? 'Berhasil' : accuracy >= 60 ? 'Perlu Latihan' : 'Gagal'
        });
        
        // Keep only last 50 records
        if (this.progress.practiceHistory.length > 50) {
            this.progress.practiceHistory = this.progress.practiceHistory.slice(0, 50);
        }
        
        this.saveProgress();
        this.checkAchievements();
    }
    
    checkAchievements() {
        const achievements = [
            {
                id: 'first_practice',
                title: 'Pemula',
                description: 'Menyelesaikan latihan pertama',
                condition: () => this.progress.practiceHistory.length >= 1
            },
            {
                id: 'consistent_learner',
                title: 'Konsisten',
                description: 'Latihan 3 hari berturut-turut',
                condition: () => this.checkConsecutiveDays(3)
            },
            {
                id: 'alphabet_master',
                title: 'Master Abjad',
                description: 'Menguasai 10 huruf',
                condition: () => Object.keys(this.progress.alphabetProgress).length >= 10
            }
        ];
        
        achievements.forEach(achievement => {
            if (achievement.condition() && !this.progress.achievements.includes(achievement.id)) {
                this.progress.achievements.push(achievement.id);
                showNotification(`Pencapaian baru: ${achievement.title}!`, 'success');
            }
        });
    }
    
    checkConsecutiveDays(days) {
        // Simplified check - in real app, this would be more sophisticated
        return this.progress.practiceHistory.length >= days;
    }
    
    getStats() {
        const totalPractice = this.progress.practiceHistory.length;
        const avgAccuracy = totalPractice > 0 ? 
            this.progress.practiceHistory.reduce((sum, record) => sum + record.accuracy, 0) / totalPractice : 0;
        
        return {
            totalPractice,
            avgAccuracy: Math.round(avgAccuracy * 10) / 10,
            masteredLetters: Object.keys(this.progress.alphabetProgress).length,
            masteredVocab: Object.keys(this.progress.vocabularyProgress).length
        };
    }
}

// Initialize progress tracker
const progressTracker = new ProgressTracker();

// Utility functions
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('id-ID', {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
    });
}

function formatTime(dateString) {
    const date = new Date(dateString);
    return date.toLocaleTimeString('id-ID', {
        hour: '2-digit',
        minute: '2-digit'
    });
}

function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Loading state management
function showLoading(element) {
    const originalContent = element.innerHTML;
    element.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
    element.disabled = true;
    
    return function hideLoading() {
        element.innerHTML = originalContent;
        element.disabled = false;
    };
}

// Error handling
window.addEventListener('error', function(event) {
    console.error('JavaScript error:', event.error);
    // Removed automatic error notification to prevent spam
});

// Export functions for use in other scripts
window.BISINDO = {
    CameraDetection,
    ProgressTracker,
    detectGesture,
    showNotification,
    formatDate,
    formatTime,
    debounce,
    showLoading
};