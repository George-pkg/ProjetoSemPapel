const express = require('express');
const path = require('path');
const cors = require('cors')

const app = express();
const port = 5000;

app.use(cors());

app.use(express.static(path.join(__dirname, 'images')));

// Rota para servir arquivos JSON da pasta "json"
app.get('/json/:filename', (req, res) => {
  const filename = req.params.filename;
  const filePath = path.join(__dirname, 'json', filename);

  res.sendFile(filePath, (err) => {
    if (err) {
      res.status(404).send('Arquivo JSON não encontrado');
    }
  });
});

app.get('/', (req, res) => {
  res.send('<h1>Servidor de imagens e JSON Node.js</h1>');
});

app.listen(port, () => {
  console.log(`Servidor está executando em http://localhost:${port}`);
});