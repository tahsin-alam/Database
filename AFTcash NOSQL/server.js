const express = require('express');
const bodyParser= require('body-parser');
const app = express();

app.use(bodyParser.urlencoded({extended: true}));
// app.set('view engine', 'ejs');

// All your handlers here...

app.listen(8080, function() {
  console.log('Server connection successul: [port: 8080]');
});

// app.get('/', (req, res) => {
//   res.sendFile(__dirname + '/index.html');
// });

//gets
app.get('/', (req, res) => {
  db.collection('items').find().toArray((err, result) => {
    if (err) return console.log(err)
    // renders index.ejs
    res.render('index.ejs', {quotes: result})
  });
});

app.get('/views/view_customer.ejs', (req, res) => {
  db.collection('customers').find().toArray((err, result) => {
    if (err) return console.log(err)
    // renders index.ejs
    res.render('view_customer.ejs', {quotes: result})
  });
});

app.get('/views/view_items.ejs', (req, res) => {
  db.collection('items').find().toArray((err, result) => {
    if (err) return console.log(err)
    // renders index.ejs
    res.render('view_items.ejs', {quotes: result})
  });
});

app.get('/views/view_cashiers.ejs', (req, res) => {
  db.collection('cashiers').find().toArray((err, result) => {
    if (err) return console.log(err)
    // renders index.ejs
    res.render('view_cashiers.ejs', {quotes: result})
  });
});

app.get('/items',function(req,res)
{
  db.collection('items').find().toArray((err, items) => {
    if (err) return console.log(err);
    res.json(items);
  });
});



//mongodb
const MongoClient = require('mongodb').MongoClient

var db

MongoClient.connect('mongodb://don:hyder@ds125053.mlab.com:25053/aftcash', (err, client) => {
  if (err) return console.log(err)
  db = client.db('aftcash') // whatever your database name is
  app.listen(3000, () => {
    console.log('listening on [8080]')
  })
})


//posts

app.post('/quotes', (req, res) => {
  db.collection('quotes').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('saved to database')
    res.redirect('/')
  })
});

app.post('/customers', (req, res) => {
  db.collection('customers').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('new customer saved to database')
    res.redirect('/')
  })
});

app.post('/items', (req, res) => {
  db.collection('items').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('new item saved to database')
    res.redirect('/')
  })
});

app.post('/cashiers', (req, res) => {
  db.collection('cashiers').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('new cashier saved to database')
    res.redirect('/')
  })
});
