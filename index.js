const express = require('express');
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);
const path = require('path'); // Import the 'path' module

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

// Socket.io connection
io.on('connection', (socket) => {
  console.log('A user connected');

  // Listen for button press events
  socket.on('buttonPress', (buttonValue) => {
    console.log(`Button ${buttonValue} pressed`);
    // Emit the button press event to all clients
    io.emit('buttonPress', buttonValue);
  });

  // Handle disconnection
  socket.on('disconnect', () => {
    console.log('User disconnected');
  });
});

// Start the server
const PORT = process.env.PORT || 3000;
http.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
