document.getElementById('summarize').addEventListener('click', async () => {
  const terms = document.getElementById('terms').value;

  // Retrieve the CSRF token from your Rails app
  const response = await fetch('http://localhost:3000/');
  const text = await response.text();
  const csrfToken = text.match(/<meta name="csrf-token" content="(.+?)"/)[1];

  // Send the terms to your Rails app
  const summaryResponse = await fetch('http://localhost:3000/summaries', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    body: JSON.stringify({ terms: terms })
  });

  const summary = await summaryResponse.text();
  document.getElementById('summary_box').value = summary;
});

