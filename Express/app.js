const express = require('express')
const morgan = require('morgan')
const mongoose = require('mongoose')
const Task = require('./models/task')
const User = require('./models/user')
const app = express()
const userRoutes = require('./routes/userRoutes')
const taskRoutes = require('./routes/taskRoutes')
const dotenv = require("dotenv");

dotenv.config();

const url = process.env.DB_URL
mongoose.connect(url, { useNewUrlParser: true })
.then((result) =>{ 
    app.listen(3000)
    console.log('connected to db')
})
.catch((err) => console.log(err))

app.use(express.json())
app.use(morgan('dev'))
app.use(express.json()) //support JSON-encoded bodies
app.use('/users',userRoutes)
app.use('/tasks',taskRoutes)
app.get('/', (req, res) => {

    res.send('hello to the backend')

})

