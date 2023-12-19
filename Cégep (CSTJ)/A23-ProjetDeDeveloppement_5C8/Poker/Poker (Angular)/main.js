//Main program

const {app, BrowserWindow} = require('electron'); 
const url = require('url'); 
const path = require('path'); 
 
function onReady () { 
 win = new BrowserWindow({width: 670, height: 300, frame: true}) //Retirer la bordure: "frame: false"
 win.loadURL(url.format({ 
 pathname: path.join( 
 __dirname, 
 'dist/poker420/index.html'), 
 protocol: 'file:', 
 slashes: true 
 })) 
} 
app.on('ready', onReady);