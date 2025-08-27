// Working solution using api.Front
api.unmap('yy');
api.mapkey('yy', 'Test popup', () => {
    api.Front.showBanner('Surfingkeys captured yy ✅');
    setTimeout(() => api.Front.hideBanner(), 1500);
});

api.unmap('zb');
api.mapkey('zb', 'BTC price (CoinGecko)', function () {
  (async () => {
    try {
      const r = await fetch('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd');
      if (!r.ok) throw new Error(`${r.status} ${r.statusText}`);
      const usd = (await r.json()).bitcoin.usd;
      showCustomBanner(`₿ BTC = $${usd.toLocaleString()}`, 2200, {
        background: '#f7931a',
        top: '70px'
      });
    } catch (e) {
      showCustomBanner(`⚠️ BTC fetch error: ${e.message || e}`, 2500, {
        background: '#e74c3c',
        top: '70px'
      });
    }
  })();
});



api.unmap('ze');
api.mapkey('ze', 'ETH price (CoinGecko)', function () {
  (async () => {
    try {
      const r = await fetch('https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd');
      if (!r.ok) throw new Error(`${r.status} ${r.statusText}`);
      const usd = (await r.json()).ethereum.usd;
      showCustomBanner(`Ξ ETH = $${usd.toLocaleString()}`, 2200, {
        background: '#627eea',   // ETH blue
        top: '70px'
      });
    } catch (e) {
      showCustomBanner(`⚠️ ETH fetch error: ${e.message || e}`, 2500, {
        background: '#e74c3c',
        top: '70px'
      });
    }
  })();
});



// Optional: Create a custom styled banner function for reuse
function showCustomBanner(message, duration = 1500, style = {}) {
    const notification = document.createElement('div');
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: ${style.top || '20px'};
        right: ${style.right || '20px'};
        background: ${style.background || '#4CAF50'};
        color: ${style.color || 'white'};
        padding: 15px 20px;
        border-radius: 5px;
        z-index: 999999;
        font-size: 16px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        transition: opacity 0.3s ease;
    `;
    document.body.appendChild(notification);
    
    // Fade out effect
    setTimeout(() => {
        notification.style.opacity = '0';
        setTimeout(() => notification.remove(), 300);
    }, duration);
}

// Example using custom banner
api.unmap('yt');
api.mapkey('yt', 'Test custom banner', () => {
    showCustomBanner('Custom styled banner! 🎨', 2000, {
        background: '#2196F3',
        top: '50px'
    });
});
