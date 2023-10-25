const express = require('express');
const cors = require("cors");
const fs = require('fs')
const app = express();
const port = 5000;

app.use(cors());

const dataDir = './data/';

// Define a route to get a specific JSON file by name
app.get('/api/:filename', (req, res) => {
  const { filename } = req.params;
  const filePath = `${dataDir}${filename}.json`;

  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      res.status(404).json({ error: 'File not found' });
    } else {
      try {
        const jsonData = JSON.parse(data);
        res.json(jsonData);
      } catch (error) {
        res.status(500).json({ error: 'Error parsing JSON' });
      }
    }
  });
});


app.listen(port, ()=> {
    console.log(`servidor iniciado na porta ${port}`)
});