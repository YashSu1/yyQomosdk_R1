const express = require('express');
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);

// Include the SDK file
const QomoSDK = require('C:\Users\Parallel-Admin\Desktop\JSapp\Qomo with exsisting remote response\R1\yyQomosdk_R1\sdk\sdk'); // Replace with the actual path to the SDK file

// Initialize the SDK
const qomoSDK = new QomoSDK();

// Handle GET request for index.html
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

// Socket.io connection
io.on('connection', (socket) => {
    console.log('A user connected');

    // Handle button press event from frontend
    socket.on('buttonPressed', (buttonValue) => {
        console.log('Button pressed:', buttonValue);

        // Here, you can call the SDK function to handle the button press
        // For example:
        qomoSDK.handleButtonPress(buttonValue);
    });

    // Handle disconnect event
    socket.on('disconnect', () => {
        console.log('User disconnected');
    });
});

// Start the server
const PORT = process.env.PORT || 3330;
http.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
