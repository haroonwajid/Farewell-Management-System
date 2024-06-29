// Database Systems PROJECT
// index.js

const express = require('express');
const mysql = require('mysql2');
const path = require('path'); 
const bodyParser = require('body-parser'); 
const app = express();

const port = 3000;
app.listen(port, function(){                         
    console.log(`Listening on port ${port}...`);   
});

// Serve static files from the "public" directory
app.use(express.static(path.join(__dirname, 'public')));

app.use(bodyParser.urlencoded({ extended: false }));

app.use(bodyParser.json());

// Set up a MySQL connection
const connection = mysql.createConnection({
    host: "localhost",
    database: "farewell_party",
    user: "root",
    password: "helloworld"
});


// Connect to MySQL
connection.connect(function(err) {         
    if (err) {
        console.error("Error connecting to MySQL:", err);
    } else {
        console.log("Connected to MySQL!");
    }
});

// Example: Retrieve data from the 'student' table
app.get('/students', function(req, res) {
    const query = 'describe student';

    connection.query(query, function(err, result) {
        if (err) {
            console.error("Error executing MySQL query:", err);
            res.status(500).send('Internal Server Error');
        } else {
            res.json(result);
        }
    });
});

// Serve the login.html file
app.get('/login', function(req, res) {
    res.sendFile(path.join(__dirname, 'login.html'));
});

/*
app.post('/login', function(req, res) {
    const { uname, psw } = req.body;

    // Define a regular expression for the expected student username format
    const studentRegex = /^\d{2}i-\d{4}$/;

    // Check if the username matches the student format
    if (studentRegex.test(uname)) {
        // It's a student
        const tableName = 'student';
        
        // Perform the student login logic here
        const query = `INSERT INTO ${tableName} (username, password) VALUES (?, ?)`;
        connection.query(query, [uname, psw], function(err, result) {
            if (err) {
                console.error("Error executing MySQL query:", err);
                res.status(500).send('Internal Server Error');
            } else {
                // Redirect to the main page after successful login
                res.redirect('/main');
            }
        });
    } else {
        // It's a teacher
        const tableName = 'teacher';

        // Perform the teacher login logic here
        const query = `INSERT INTO ${tableName} (username, password) VALUES (?, ?)`;
        connection.query(query, [uname, psw], function(err, result) {
            if (err) {
                console.error("Error executing MySQL query:", err);
                res.status(500).send('Internal Server Error');
            } else {
                // Redirect to the main page after successful login
                res.redirect('/main_teachers');
            }
        });
    }
});*/



app.get('/register', function (req, res) {
    res.sendFile(path.join(__dirname, 'register.html'));
});

app.get('/main', function (req, res) {
    res.sendFile(path.join(__dirname, 'main.html'));
});

app.get('/vote', function (req, res) {
    res.sendFile(path.join(__dirname, 'vote.html'));
});

app.get('/performance', function (req, res) {
    res.sendFile(path.join(__dirname, 'performance.html'));
});

app.get('/editprofile', function (req, res) {
    res.sendFile(path.join(__dirname, 'editprofile.html'));
});


app.get('/ticket', function (req, res) {
    res.sendFile(path.join(__dirname, 'ticket.html'));
});

app.post('/ticket', function(req, res) {
    const { numTickets, cardNumber, expiryDate, cvv } = req.body;

    console.log(`Purchased ${numTickets} tickets with Card ${cardNumber}, Expiry ${expiryDate}, CVV ${cvv}`);

    // Redirect to the main page or a confirmation page
    res.redirect('/main');
});
