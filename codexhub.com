<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>NovaTrade · realistic trading UI</title>
  <!-- Font & icons -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Inter', sans-serif;
    }

    body {
      background: #0b0e14;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 16px;
    }

    /* main dashboard card – realistic trading terminal */
    .terminal {
      max-width: 1440px;
      width: 100%;
      background: #131722;
      border-radius: 28px;
      box-shadow: 0 30px 50px rgba(0, 0, 0, 0.7), 0 0 0 1px rgba(255, 255, 255, 0.03);
      overflow: hidden;
      padding: 24px 28px;
      transition: all 0.2s;
    }

    /* ---------- HEADER ---------- */
    .header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 28px;
      flex-wrap: wrap;
      gap: 16px;
    }

    .logo-area {
      display: flex;
      align-items: center;
      gap: 12px;
    }

    .logo-icon {
      background: linear-gradient(135deg, #2962ff, #7b61ff);
      width: 38px;
      height: 38px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      color: white;
      box-shadow: 0 6px 12px rgba(41, 98, 255, 0.25);
    }

    .logo-text {
      font-weight: 700;
      font-size: 18px;
      letter-spacing: -0.3px;
      color: white;
    }

    .logo-text span {
      color: #2962ff;
      font-weight: 500;
      margin-left: 2px;
    }

    .search-bar {
      background: #1e2530;
      border-radius: 40px;
      padding: 10px 18px;
      display: flex;
      align-items: center;
      gap: 10px;
      width: 300px;
      border: 1px solid #2a3441;
      transition: all 0.2s;
    }

    .search-bar i {
      color: #8b99ae;
      font-size: 14px;
    }

    .search-bar input {
      background: transparent;
      border: none;
      outline: none;
      color: #e8edf5;
      font-size: 14px;
      width: 100%;
      font-weight: 400;
    }

    .search-bar input::placeholder {
      color: #5e6e84;
    }

    .header-actions {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .balance-badge {
      background: #1e2530;
      border-radius: 40px;
      padding: 8px 18px;
      border: 1px solid #2a3441;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .balance-badge .label {
      font-size: 13px;
      color: #8b99ae;
      font-weight: 500;
    }

    .balance-badge .value {
      font-weight: 700;
      color: #e8edf5;
      font-size: 16px;
      letter-spacing: -0.2px;
    }

    .balance-badge .currency {
      color: #2962ff;
      font-weight: 600;
      font-size: 14px;
    }

    .avatar {
      background: #2962ff;
      width: 40px;
      height: 40px;
      border-radius: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: 600;
      font-size: 16px;
      border: 2px solid #2a3441;
      cursor: pointer;
    }

    /* ---------- STATS ROW ---------- */
    .stats-row {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 16px;
      margin-bottom: 24px;
    }

    .stat-card {
      background: #1a1f2b;
      border-radius: 20px;
      padding: 18px 20px;
      border: 1px solid #232a36;
      display: flex;
      align-items: center;
      justify-content: space-between;
      transition: all 0.2s;
    }

    .stat-left h4 {
      font-size: 13px;
      font-weight: 500;
      color: #8b99ae;
      letter-spacing: 0.2px;
      margin-bottom: 6px;
    }

    .stat-left .value {
      font-size: 24px;
      font-weight: 700;
      color: white;
      letter-spacing: -0.5px;
    }

    .stat-left .value small {
      font-size: 14px;
      font-weight: 500;
      color: #7b8ba3;
      margin-left: 4px;
    }

    .change-badge {
      padding: 4px 10px;
      border-radius: 30px;
      font-size: 12px;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 4px;
    }

    .change-badge.up {
      background: rgba(0, 200, 120, 0.12);
      color: #00c878;
    }

    .change-badge.down {
      background: rgba(255, 70, 70, 0.12);
      color: #ff4646;
    }

    /* ---------- MAIN PANELS ---------- */
    .main-grid {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 20px;
      margin-bottom: 20px;
    }

    /* chart panel */
    .chart-panel {
      background: #1a1f2b;
      border-radius: 24px;
      padding: 20px 20px 12px 20px;
      border: 1px solid #232a36;
      display: flex;
      flex-direction: column;
    }

    .chart-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 18px;
    }

    .pair-selector {
      display: flex;
      align-items: center;
      gap: 16px;
    }

    .pair-selector .pair {
      font-size: 18px;
      font-weight: 700;
      color: white;
      letter-spacing: -0.3px;
    }

    .pair-selector .pair i {
      font-size: 12px;
      color: #5e6e84;
      margin-left: 6px;
    }

    .price-info {
      display: flex;
      align-items: center;
      gap: 14px;
    }

    .price-info .current {
      font-size: 20px;
      font-weight: 700;
      color: white;
    }

    .price-info .change {
      font-size: 14px;
      font-weight: 600;
    }

    .change.up {
      color: #00c878;
    }

    .change.down {
      color: #ff4646;
    }

    .time-filters {
      display: flex;
      gap: 6px;
      background: #131722;
      padding: 4px;
      border-radius: 40px;
    }

    .time-filters button {
      background: transparent;
      border: none;
      color: #8b99ae;
      font-size: 12px;
      font-weight: 600;
      padding: 6px 12px;
      border-radius: 30px;
      cursor: pointer;
      transition: all 0.15s;
    }

    .time-filters button.active {
      background: #2962ff;
      color: white;
      box-shadow: 0 4px 8px rgba(41, 98, 255, 0.25);
    }

    /* chart canvas area */
    .canvas-container {
      position: relative;
      width: 100%;
      height: 240px;
      margin-top: 8px;
    }

    #priceChart {
      width: 100%;
      height: 100%;
      display: block;
      border-radius: 12px;
    }

    /* bottom stats under chart */
    .chart-footer {
      display: flex;
      justify-content: space-between;
      margin-top: 14px;
      padding: 0 4px;
    }

    .metric {
      display: flex;
      flex-direction: column;
    }

    .metric .label {
      font-size: 11px;
      color: #6e7d94;
      font-weight: 500;
      letter-spacing: 0.3px;
    }

    .metric .val {
      font-size: 14px;
      font-weight: 600;
      color: #d0dae8;
    }

    /* order book panel */
    .orderbook-panel {
      background: #1a1f2b;
      border-radius: 24px;
      padding: 20px;
      border: 1px solid #232a36;
      display: flex;
      flex-direction: column;
    }

    .orderbook-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 16px;
    }

    .orderbook-header h3 {
      font-size: 16px;
      font-weight: 600;
      color: white;
    }

    .orderbook-header span {
      font-size: 12px;
      color: #8b99ae;
      background: #131722;
      padding: 4px 10px;
      border-radius: 20px;
    }

    .orderbook-list {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .order-row {
      display: flex;
      justify-content: space-between;
      font-size: 13px;
      font-weight: 500;
      padding: 6px 8px;
      border-radius: 8px;
      transition: background 0.1s;
      cursor: default;
    }

    .order-row.bid {
      background: rgba(0, 200, 120, 0.06);
    }

    .order-row.ask {
      background: rgba(255, 70, 70, 0.06);
    }

    .order-row .price {
      font-weight: 600;
    }

    .order-row.bid .price {
      color: #00c878;
    }

    .order-row.ask .price {
      color: #ff4646;
    }

    .order-row .amount {
      color: #a8b6cc;
    }

    .order-row .total {
      color: #6e7d94;
      font-weight: 400;
    }

    .spread-badge {
      text-align: center;
      font-size: 12px;
      font-weight: 600;
      color: #8b99ae;
      background: #131722;
      padding: 6px;
      border-radius: 12px;
      margin: 8px 0;
    }

    /* ---------- BOTTOM PANEL: TRADE / POSITIONS ---------- */
    .bottom-panel {
      display: grid;
      grid-template-columns: 1fr 1.2fr;
      gap: 20px;
      margin-top: 8px;
    }

    .trade-box, .positions-box {
      background: #1a1f2b;
      border-radius: 24px;
      padding: 20px;
      border: 1px solid #232a36;
    }

    .trade-box h3, .positions-box h3 {
      font-size: 16px;
      font-weight: 600;
      color: white;
      margin-bottom: 18px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .trade-form {
      display: flex;
      flex-direction: column;
      gap: 16px;
    }

    .input-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .input-group label {
      font-size: 12px;
      font-weight: 500;
      color: #8b99ae;
      letter-spacing: 0.2px;
    }

    .input-group input, .input-group select {
      background: #131722;
      border: 1px solid #2a3441;
      border-radius: 14px;
      padding: 12px 16px;
      color: white;
      font-size: 14px;
      font-weight: 500;
      outline: none;
      transition: border 0.15s;
    }

    .input-group input:focus, .input-group select:focus {
      border-color: #2962ff;
    }

    .input-group input::placeholder {
      color: #4e5e74;
    }

    .trade-actions {
      display: flex;
      gap: 12px;
      margin-top: 6px;
    }

    .btn {
      flex: 1;
      border: none;
      border-radius: 40px;
      padding: 12px 16px;
      font-weight: 600;
      font-size: 14px;
      cursor: pointer;
      transition: all 0.15s;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .btn-buy {
      background: #00c878;
      color: #0b0e14;
      box-shadow: 0 8px 16px rgba(0, 200, 120, 0.2);
    }

    .btn-buy:hover {
      background: #00b36b;
      transform: translateY(-1px);
    }

    .btn-sell {
      background: #ff4646;
      color: white;
      box-shadow: 0 8px 16px rgba(255, 70, 70, 0.2);
    }

    .btn-sell:hover {
      background: #e63e3e;
      transform: translateY(-1px);
    }

    /* positions table */
    .positions-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 13px;
    }

    .positions-table th {
      text-align: left;
      font-size: 11px;
      font-weight: 600;
      color: #6e7d94;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      padding-bottom: 12px;
    }

    .positions-table td {
      padding: 10px 0;
      border-bottom: 1px solid #232a36;
      color: #d0dae8;
      font-weight: 500;
    }

    .positions-table tr:last-child td {
      border-bottom: none;
    }

    .positions-table .profit {
      color: #00c878;
      font-weight: 600;
    }

    .positions-table .loss {
      color: #ff4646;
      font-weight: 600;
    }

    .positions-table .symbol {
      font-weight: 600;
      color: white;
    }

    /* ---------- RESPONSIVE ---------- */
    @media (max-width: 1100px) {
      .terminal {
        padding: 20px;
      }
      .stats-row {
        grid-template-columns: repeat(2, 1fr);
      }
      .main-grid {
        grid-template-columns: 1fr;
      }
      .bottom-panel {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 700px) {
      .header {
        flex-direction: column;
        align-items: flex-start;
      }
      .search-bar {
        width: 100%;
      }
      .stats-row {
        grid-template-columns: 1fr;
      }
      .trade-actions {
        flex-direction: column;
      }
      .balance-badge .label {
        display: none;
      }
    }

    /* small scrollbar for orderbook */
    .orderbook-list::-webkit-scrollbar {
      width: 4px;
    }
    .orderbook-list::-webkit-scrollbar-thumb {
      background: #2a3441;
      border-radius: 4px;
    }
  </style>
</head>
<body>
  <div class="terminal">
    <!-- ========== HEADER ========= -->
    <div class="header">
      <div class="logo-area">
        <div class="logo-icon"><i class="fas fa-chart-line"></i></div>
        <div class="logo-text">Nova<span>Trade</span></div>
      </div>
      <div class="search-bar">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Search markets, symbols...">
      </div>
      <div class="header-actions">
        <div class="balance-badge">
          <span class="label">Balance</span>
          <span class="value">$48,320.50</span>
          <span class="currency">USD</span>
        </div>
        <div class="avatar">JD</div>
      </div>
    </div>

    <!-- ========== STATS ROW ========= -->
    <div class="stats-row">
      <div class="stat-card">
        <div class="stat-left">
          <h4>Total P&L</h4>
          <div class="value">+$2,845<small>.30</small></div>
        </div>
        <div class="change-badge up"><i class="fas fa-arrow-up"></i> +8.2%</div>
      </div>
      <div class="stat-card">
        <div class="stat-left">
          <h4>Margin used</h4>
          <div class="value">$12,400<small>.00</small></div>
        </div>
        <div class="change-badge down"><i class="fas fa-arrow-down"></i> 25.6%</div>
      </div>
      <div class="stat-card">
        <div class="stat-left">
          <h4>Open positions</h4>
          <div class="value">6</div>
        </div>
        <div class="change-badge up" style="background: rgba(41,98,255,0.12); color:#2962ff;">Active</div>
      </div>
      <div class="stat-card">
        <div class="stat-left">
          <h4>Win rate</h4>
          <div class="value">74<small>%</small></div>
        </div>
        <div class="change-badge up"><i class="fas fa-arrow-up"></i> +2.1%</div>
      </div>
    </div>

    <!-- ========== MAIN GRID (chart + orderbook) ========= -->
    <div class="main-grid">
      <!-- chart panel -->
      <div class="chart-panel">
        <div class="chart-header">
          <div class="pair-selector">
            <span class="pair">BTC / USD <i class="fas fa-chevron-down"></i></span>
          </div>
          <div class="price-info">
            <span class="current">$63,842.10</span>
            <span class="change up"><i class="fas fa-caret-up"></i> +2.34%</span>
          </div>
          <div class="time-filters">
            <button>1H</button>
            <button class="active">1D</button>
            <button>1W</button>
            <button>1M</button>
          </div>
        </div>
        <div class="canvas-container">
          <canvas id="priceChart" width="800" height="240"></canvas>
        </div>
        <div class="chart-footer">
          <div class="metric"><span class="label">24h High</span><span class="val">$64,210</span></div>
          <div class="metric"><span class="label">24h Low</span><span class="val">$61,980</span></div>
          <div class="metric"><span class="label">Volume</span><span class="val">1.28B</span></div>
          <div class="metric"><span class="label">Volatility</span><span class="val">2.4%</span></div>
        </div>
      </div>

      <!-- order book panel -->
      <div class="orderbook-panel">
        <div class="orderbook-header">
          <h3><i class="fas fa-list-ul" style="margin-right: 6px; color: #2962ff;"></i> Order Book</h3>
          <span>BTC/USD</span>
        </div>
        <div class="orderbook-list" id="orderbookList">
          <!-- filled via JS -->
        </div>
        <div class="spread-badge" id="spreadBadge">Spread 0.02%</div>
      </div>
    </div>

    <!-- ========== BOTTOM (trade + positions) ========= -->
    <div class="bottom-panel">
      <!-- trade box -->
      <div class="trade-box">
        <h3><i class="fas fa-bolt" style="color: #2962ff;"></i> Quick Trade</h3>
        <div class="trade-form">
          <div class="input-group">
            <label>Order type</label>
            <select>
              <option>Market</option>
              <option>Limit</option>
              <option>Stop</option>
            </select>
          </div>
          <div class="input-group">
            <label>Amount (BTC)</label>
            <input type="number" value="0.05" step="0.001" min="0.001">
          </div>
          <div class="trade-actions">
            <button class="btn btn-buy" id="buyBtn"><i class="fas fa-arrow-up"></i> Buy / Long</button>
            <button class="btn btn-sell" id="sellBtn"><i class="fas fa-arrow-down"></i> Sell / Short</button>
          </div>
        </div>
      </div>

      <!-- positions box -->
      <div class="positions-box">
        <h3><i class="fas fa-briefcase" style="color: #2962ff;"></i> Open Positions</h3>
        <table class="positions-table">
          <thead>
            <tr><th>Symbol</th><th>Size</th><th>Entry</th><th>P&L</th></tr>
          </thead>
          <tbody>
            <tr><td class="symbol">BTC/USD</td><td>0.25</td><td>$62,410</td><td class="profit">+$358.2</td></tr>
            <tr><td class="symbol">ETH/USD</td><td>2.80</td><td>$3,420</td><td class="loss">-$124.6</td></tr>
            <tr><td class="symbol">SOL/USD</td><td>14.0</td><td>$142.3</td><td class="profit">+$86.4</td></tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <script>
    (function() {
      // ---------- 1. ORDER BOOK (realistic dynamic data) ----------
      const orderbookList = document.getElementById('orderbookList');
      const spreadBadge = document.getElementById('spreadBadge');

      // generate order book around current price (BTC ~63842)
      function generateOrderBook() {
        const midPrice = 63842.10;
        const bids = [];
        const asks = [];

        // generate bids (descending price)
        for (let i = 0; i < 5; i++) {
          const price = midPrice - 8 - i * 12 + (Math.random() * 4 - 2);
          const amount = (Math.random() * 2.5 + 0.2).toFixed(2);
          const total = (price * amount).toFixed(0);
          bids.push({ price: price.toFixed(2), amount, total });
        }

        // generate asks (ascending price)
        for (let i = 0; i < 5; i++) {
          const price = midPrice + 8 + i * 12 + (Math.random() * 4 - 2);
          const amount = (Math.random() * 2.5 + 0.2).toFixed(2);
          const total = (price * amount).toFixed(0);
          asks.push({ price: price.toFixed(2), amount, total });
        }

        // sort: bids descending, asks ascending
        bids.sort((a, b) => parseFloat(b.price) - parseFloat(a.price));
        asks.sort((a, b) => parseFloat(a.price) - parseFloat(b.price));

        // render rows (bids first – highest to lowest)
        let html = '';
        // bids
        bids.forEach(b => {
          html += `<div class="order-row bid">
            <span class="price">${b.price}</span>
            <span class="amount">${b.amount}</span>
            <span class="total">${b.total}</span>
          </div>`;
        });

        // spread indicator (using best bid/ask)
        const bestBid = parseFloat(bids[0].price);
        const bestAsk = parseFloat(asks[0].price);
        const spread = ((bestAsk - bestBid) / bes