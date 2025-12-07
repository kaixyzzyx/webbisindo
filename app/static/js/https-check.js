/**
 * Check HTTPS requirement for camera access
 */
(function() {
    // Check if running on HTTP (not HTTPS) and not localhost
    if (location.protocol !== 'https:' && location.hostname !== 'localhost' && location.hostname !== '127.0.0.1') {
        // Show warning banner
        const banner = document.createElement('div');
        banner.className = 'alert alert-warning alert-dismissible fade show position-fixed';
        banner.style.cssText = 'top: 0; left: 0; right: 0; z-index: 10000; margin: 0; border-radius: 0;';
        banner.innerHTML = `
            <div class="container">
                <i class="fas fa-exclamation-triangle"></i>
                <strong>Peringatan:</strong> Akses kamera memerlukan HTTPS. 
                <a href="https://${location.host}${location.pathname}${location.search}" class="alert-link">
                    Klik di sini untuk menggunakan HTTPS
                </a>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `;
        
        // Add to page
        document.body.insertBefore(banner, document.body.firstChild);
        
        // Add top margin to body to accommodate banner
        document.body.style.paddingTop = '60px';
        
        // Remove padding when banner is closed
        banner.addEventListener('closed.bs.alert', function() {
            document.body.style.paddingTop = '0';
        });
    }
})();