// Theme Management for Tracker de Mamadas
// Carrega e aplica o tema salvo pelo usuário

(function() {
    // Theme definitions
    const themes = {
        brown: {
            '--primary-color': '#8B6F47',
            '--secondary-color': '#A0826D',
            '--accent-color': '#D4A574',
            '--light-color': '#F5E6D3',
            '--dark-color': '#5D4E37',
            '--gradient-start': '#C4A484',
            '--gradient-end': '#8B7355'
        },
        blue: {
            '--primary-color': '#667eea',
            '--secondary-color': '#764ba2',
            '--accent-color': '#8860d6',
            '--light-color': '#e8eaf6',
            '--dark-color': '#4a4a6a',
            '--gradient-start': '#667eea',
            '--gradient-end': '#764ba2'
        },
        pink: {
            '--primary-color': '#f5576c',
            '--secondary-color': '#f093fb',
            '--accent-color': '#ff8a9d',
            '--light-color': '#fff0f3',
            '--dark-color': '#a6384a',
            '--gradient-start': '#f093fb',
            '--gradient-end': '#f5576c'
        },
        green: {
            '--primary-color': '#11998e',
            '--secondary-color': '#38ef7d',
            '--accent-color': '#20e6a8',
            '--light-color': '#e0f7f0',
            '--dark-color': '#0d7a73',
            '--gradient-start': '#11998e',
            '--gradient-end': '#38ef7d'
        },
        purple: {
            '--primary-color': '#8E2DE2',
            '--secondary-color': '#4A00E0',
            '--accent-color': '#a855f7',
            '--light-color': '#f3e8ff',
            '--dark-color': '#5c1db8',
            '--gradient-start': '#8E2DE2',
            '--gradient-end': '#4A00E0'
        }
    };

    // Load saved theme or default to brown
    const savedTheme = localStorage.getItem('theme') || 'brown';

    // Apply theme
    function applyTheme(themeName) {
        const theme = themes[themeName];
        if (!theme) return;

        const root = document.documentElement;
        for (const [property, value] of Object.entries(theme)) {
            root.style.setProperty(property, value);
        }
    }

    // Apply theme as soon as possible
    applyTheme(savedTheme);

    // Re-apply when DOM is loaded (in case of race conditions)
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            applyTheme(savedTheme);
        });
    }
})();
