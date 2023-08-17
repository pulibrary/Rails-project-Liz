// connect4 tutorial for initial implementation: https://youtu.be/4ARsthVnCTg 

const playerRed = "R";
const playerYellow = "Y";
let currPlayer = playerRed;

let gameOver = false;
let roundOver = false;
let board;

const rows = 6;
const columns = 7;
let currColumns = []; //keeps track of which row each column is at.

let usernameRedPlayer = document.getElementById("red-player").innerText
console.log(`red player = ${usernameRedPlayer}`)
let usernameYellowPlayer = document.getElementById("yellow-player").innerText;
console.log(`Yellow player = ${usernameYellowPlayer}`)
let rounds = 1;
let totalRounds = parseInt(document.getElementById("number-of-rounds").getAttribute("data-rounds"), 10);
console.log(`totalRounds = ${totalRounds}`);

if (window.location.pathname.startsWith("/show_game")) {
    console.log("start of onload");
    setGame();
    console.log("we've set game");
    createNextRoundButton();
    createNewGameButton();
    setTurn();
    setRound();
}

function setTurn() {
    // indicate whose turn it is; I am reusing the h2 level header that announces the winner of each round.
    let turn = document.getElementById("winner");
    if (currPlayer == "R") {
        turn.innerText = `${usernameRedPlayer}'s turn to play!`;
        winner.className = "red-text"; 
    } else {
        turn.innerText = `${usernameYellowPlayer}'s turn to play!`;
        winner.className = "yellow-text"; 
    }
}

function setRound() {
    let roundHeader = document.getElementById("round-header");
    roundHeader.innerText = `Round ${rounds}/${totalRounds}`;
}

function setGame() {
    board = [];
    // row height of 0 to 5 indexed for each column. We start at 5, the bottom.
    currColumns = [5, 5, 5, 5, 5, 5, 5];

    // Clear out (any) existing board for next round
    const boardElement = document.getElementById("board");
    boardElement.innerHTML = "";

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
            // adds the tile (div element) to the end of this "board" element's list of child nodes.
            document.getElementById("board").append(tile);
        }
        board.push(row);
    }
}

// this function is supposed to run ONCE.
function createNextRoundButton() {
    // create "Next Round" button
    let buttonDiv = document.getElementById("connect4-button-div");

    var button = document.createElement("button");
    button.setAttribute("hidden", "");
    button.id = "next-round-button";
    button.textContent = "Next Round";
    button.classList.add("decor-button", "button-shadow");
    button.style.cursor = "pointer";
    
    // set event listener - we set up once.
    button.addEventListener("click", function(event) {
        if (gameOver) {
            return;
        }
        // Prevent the default link behavior (don't want to navigate anywhere)
        event.preventDefault();
        let winner = document.getElementById("winner");
        winner.innerText = "";
        roundOver = false;
        setGame();
        setTurn();
        setRound();
        // hide nextRound button
        this.setAttribute("hidden", "");
    });

    buttonDiv.appendChild(button);
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

function setPiece() {
    console.log("Setting piece!")
    if (gameOver || roundOver) {
        return;
    }
    console.log(`gameOver = ${gameOver}`)

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

    setTurn();
    checkWinner();
}

function checkWinner() {
     // horizontal
     for (let r = 0; r < rows; r++) {
         for (let c = 0; c < columns - 3; c++){ // 0 to 3 = 4 tiles
            if (board[r][c] != ' ') { // if current tile does not have red or yellow, skip.
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
    console.log("Inside setWinner!")
    roundOver = true;
    rounds += 1;
    console.log(`rounds = ${rounds}`)
    let redScoreElement = document.getElementById("red-score");
    let yellowScoreElement = document.getElementById("yellow-score");
    let winner = document.getElementById("winner");

    if (board[r][c] == playerRed) {
        winner.innerText = `${usernameRedPlayer} Wins!`;   
        winner.className = "red-text";
        // update round score
        setScore(redScoreElement);

    } else {
        winner.innerText = `${usernameYellowPlayer} Wins!`;
        winner.className = "yellow-text";
        // update round score
        setScore(yellowScoreElement);
    }

    console.log(`rounds again = ${rounds}`)
    console.log(`totalRounds = ${totalRounds + 1}`)
    console.log(rounds == (totalRounds + 1))
    // Handle when game is over
    if (rounds == totalRounds + 1) { // + 1 to indicate we would be at 4th round, meaning we finished 3 rounds.
        console.log("game is over!")
        gameOver = true;
        let roundHeader = document.getElementById("round-header");
        roundHeader.className = "game-over";
        roundHeader.innerText = "Game Over!";

        // determine who is the FINAL WINNER of game (not the round) after final score update.
        if (getScore(redScoreElement) > getScore(yellowScoreElement)) {
            winner.innerText = `${usernameRedPlayer} is the final winner!`;
            winner.className = "red-text";
            // pass username to set cumulative score of winner
            updateScore(usernameRedPlayer)

        } else {
            winner.innerText = `${usernameYellowPlayer} is the final winner!`;
            winner.className = "yellow-text";
            updateScore(usernameYellowPlayer)
        } 

        // show button to start new game => reload of page
        console.log("Setting start new game button")
        var button = document.getElementById("start-new-game-button");
        button.removeAttribute("hidden");
    }

    if (!gameOver) {
        // show button to begin next round
        var button = document.getElementById("next-round-button");
        button.removeAttribute("hidden");
    }
}

// cumulative score of winner-player for today
async function updateScore(username) {
    console.log(`username in updateScore = ${username}`)
    let response;
    try {
        response = await fetch("/update?username=" + encodeURIComponent(username), {
            method: "PATCH",
            headers: {
                "X-CSRF-Token": getMetaContent('csrf-token')
            }
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
    } catch (error) {
        console.error("Server error: ", response.textContent);
        throw new Error(error);
    }
}

// score of round
function setScore(element) { 
    let score = getScore(element);
    element.innerText = `Score: ${parseInt(score, 10) + 1}`;
}

function getScore(element) {
    let scoreString = element.innerText;
    let score = parseInt(scoreString.charAt(scoreString.length - 1), 10);
    return score
}

function createNewGameButton() {
    let buttonDiv = document.getElementById("connect4-button-div");
    // create game over button
    var button = document.createElement("button");
    button.setAttribute("hidden", "");
    button.id = "start-new-game-button";
    button.textContent = "Start New Game";
    button.classList.add("decor-button", "button-shadow");
    button.style.cursor = "pointer";

    button.addEventListener("click", function() {
        window.location.href = "/setup_game";
        this.setAttribute("hidden", "")
    });

    buttonDiv.appendChild(button);
}