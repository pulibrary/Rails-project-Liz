let playerRed = "R";
let playerYellow = "Y";
let currPlayer = playerRed;

let gameOver = false;
let board;

let rows = 6;
let columns = 7;
let currColumns = []; //keeps track of which row each column is at.

let usernameRedPlayer;
let usernameYellowPlayer;

window.onload = async function() {
    await loginPlayers();
    setGame(usernameRedPlayer, usernameYellowPlayer);
}

async function loginPlayers() {
    let redPlayer = document.getElementById("red-player");
    let yellowPlayer = document.getElementById("yellow-player");
    
    try {
        usernameRedPlayer = await getPlayerUsername('RED');
        redPlayer.innerText = `Red Player: ${usernameRedPlayer}`;
        usernameYellowPlayer = await getPlayerUsername('YELLOW');
        yellowPlayer.innerText = `Yellow Player: ${usernameYellowPlayer}`;
        
    } catch (error) {
        console.error("Error:", error);
        throw new Error(error)
    }
}

async function getPlayerUsername(color) {
    let username;
    let notValid = true;
        while (notValid) {
            username = prompt(`Please enter your username to play as the ${color} player:`);
            //By utilizing async/await, the function returns a Promise that resolves to either true or false
            if (await checkUsernameValidity(username)) {
                console.log("Test: inside 1st while loop")
                notValid = false;
            }
        }
        console.log("Test: after while loops")
        console.log("Test: user = " + username)
    return username
}

// this function is used to get the CSRF token from the meta tags that Rails automatically
// inserts into the page when you use <%= csrf_meta_tags %>. 
// IMPORTANT: For every user session, a token is generated.
// This token is then used to make sure that the JavaScript fetch request is authorized
//  and isn't a cross-site request forgery.
// It will look for a meta tag like: <meta name="csrf-token" content="some_token_value">.
//  ** It's a mechanism to verify that form submissions or AJAX requests made to your Rails application
// come from the application's own pages and not from external sources.
function getMetaContent(metaName) {
    return document.querySelector("meta[name='" + metaName + "']").getAttribute("content");
  }

async function checkUsernameValidity(username) {
    try {
        // The encoding ensures that characters, which might be interpreted 
        // as control characters in the URL, are safely transmitted.
        // When the encoded URL reaches the Rails server, Rails automatically
        // decodes the parameters for you. So, by the time you access params[:username],
        // the value is already decoded, and you get the original username string that 
        // you can use to look up in your database.
        const response = await fetch("/validate_username?username=" + encodeURIComponent(username), {
            method: "GET",
            headers: {
                "X-CSRF-Token": getMetaContent('csrf-token')
            }
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const data = await response.json();
        
        if (data.valid) {
            console.log(data.message);  // username exists
            return true;
        } else {
            console.log(data.message);  // username does not exist
            return false;
        }
    } catch (error) {
        console.error("Error:", error);
        // Depending on how you want to handle errors, you might return false, true, or throw the error again.
        throw new Error(error);
    }
}

function setGame() {
    board = [];
    // row height of 0 to 5 indexed for each column. We start at 5, the bottom.
    currColumns = [5, 5, 5, 5, 5, 5, 5];

    for (let r = 0; r < rows; r++) {
        let row = [];
        for (let c = 0; c < columns; c++) {
            // JS; ' ' is a placeholder for "R" and "Y" in the board. 
            // ' ' means it has not been set to a color.
            row.push(' ');
            // HTML
            let tile = document.createElement("div");
            tile.id = r.toString() + "-" + c.toString();
            tile.classList.add("tile");
            tile.addEventListener("click", setPiece);
            document.getElementById("board").append(tile);
        }
        board.push(row);
    }
}

function setPiece() {
    if (gameOver) {
        return;
    }

    // get coords of the tile clicked
    let coords = this.id.split("-");
    let r = parseInt(coords[0]);
    let c = parseInt(coords[1]);

    // figure out which row the current column should be on
    r = currColumns[c]; 

    if (r < 0) { // as we set tiles, we subtract 1 from r. Check if out of bounds. board[r][c] != ' '
        return;
    }

    board[r][c] = currPlayer; // update JS board
    let tile = document.getElementById(r.toString() + "-" + c.toString());
    if (currPlayer == playerRed) {
        tile.classList.add("red-piece");
        currPlayer = playerYellow;
    }
    else {
        tile.classList.add("yellow-piece");
        currPlayer = playerRed;
    }

    r -= 1; // update the row height for that column
    currColumns[c] = r; // update the array

    checkWinner();
}

function checkWinner() {
     // horizontal
     for (let r = 0; r < rows; r++) {
         for (let c = 0; c < columns - 3; c++){ // 0 to 3 = 4 tiles
            if (board[r][c] != ' ') { // TODO: needed check?
                if (board[r][c] == board[r][c+1] && board[r][c+1] == board[r][c+2] && board[r][c+2] == board[r][c+3]) {
                    setWinner(r, c);
                    return;
                }
            }
         }
    }

    // vertical
    for (let c = 0; c < columns; c++) {
        for (let r = 0; r < rows - 3; r++) {
            if (board[r][c] != ' ') {
                if (board[r][c] == board[r+1][c] && board[r+1][c] == board[r+2][c] && board[r+2][c] == board[r+3][c]) {
                    setWinner(r, c);
                    return;
                }
            }
        }
    }

    // anti diagonal
    for (let r = 0; r < rows - 3; r++) {
        for (let c = 0; c < columns - 3; c++) {
            if (board[r][c] != ' ') {
                if (board[r][c] == board[r+1][c+1] && board[r+1][c+1] == board[r+2][c+2] && board[r+2][c+2] == board[r+3][c+3]) {
                    setWinner(r, c);
                    return;
                }
            }
        }
    }

    // diagonal
    for (let r = 3; r < rows; r++) {
        for (let c = 0; c < columns - 3; c++) {
            if (board[r][c] != ' ') {
                if (board[r][c] == board[r-1][c+1] && board[r-1][c+1] == board[r-2][c+2] && board[r-2][c+2] == board[r-3][c+3]) {
                    setWinner(r, c);
                    return;
                }
            }
        }
    }
}

function setWinner(r, c) {
    let winner = document.getElementById("winner");
    if (board[r][c] == playerRed) {
        winner.innerText = `${usernameRedPlayer} Wins!`;   
        winner.classList.add("winner-red")          
    } else {
        winner.innerText = `${usernameYellowPlayer} Wins!`;
        winner.classList.add("winner-yellow")
    }
    // set score for winner.

    gameOver = true;
}