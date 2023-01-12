const express = require('express')
const morgan = require('morgan')
const mongoose = require('mongoose')
const Task = require('./models/task')
const User = require('./models/user')
const app = express()
const userRoutes = require('./routes/userRoutes')
const taskRoutes = require('./routes/taskRoutes')
const dotenv = require("dotenv").config();
const bodyParser = require('body-parser');

const url = "mongodb+srv://userTBD:ikEgsDiZCxkvzclY@users.0sv7cig.mongodb.net/Users"
console.log(url)

mongoose.connect(url, { useNewUrlParser: true })
.then((result) =>{ 
    app.listen(3000)
    console.log('connected to db')
})
.catch((err) => console.log(err))

app.use(bodyParser.json());
app.use(express.json())
app.use(morgan('dev'))
app.use(express.json()) //support JSON-encoded bodies
app.use('/users',userRoutes)
app.use('/tasks',taskRoutes)
app.get('/', (req, res) => {

    res.send('hello to the backend')

})
