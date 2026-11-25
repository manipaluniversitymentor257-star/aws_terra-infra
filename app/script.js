
const puzzle = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9]
];

const solution = [
    [5, 3, 4, 6, 7, 8, 9, 1, 2],
    [6, 7, 2, 1, 9, 5, 3, 4, 8],
    [1, 9, 8, 3, 4, 2, 5, 6, 7],
    [8, 5, 9, 7, 6, 1, 4, 2, 3],
    [4, 2, 6, 8, 5, 3, 7, 9, 1],
    [7, 1, 3, 9, 2, 4, 8, 5, 6],
    [9, 6, 1, 5, 3, 7, 2, 8, 4],
    [2, 8, 7, 4, 1, 9, 6, 3, 5],
    [3, 4, 5, 2, 8, 6, 1, 7, 9]
];

let board = puzzle.map(row => [...row]);
let selectedCell = null;
let mistakes = 0;
let seconds = 0;

const sudokuBoard = document.getElementById("sudoku-board");
const numberPad = document.getElementById("number-pad");
const timerElement = document.getElementById("timer");
const mistakesElement = document.getElementById("mistakes");

function renderBoard() {
    sudokuBoard.innerHTML = "";

    for (let row = 0; row < 9; row++) {
        for (let col = 0; col < 9; col++) {
            const cell = document.createElement("div");

            cell.classList.add("cell");
            cell.dataset.row = row;
            cell.dataset.col = col;

            if (board[row][col] !== 0) {
                cell.textContent = board[row][col];
            }

            if (puzzle[row][col] !== 0) {
                cell.classList.add("fixed");
            }

            if (
                selectedCell &&
                selectedCell.row === row &&
                selectedCell.col === col
            ) {
                cell.classList.add("selected");
            }

            cell.addEventListener("click", () => {
                selectedCell = { row, col };
                renderBoard();
            });

            sudokuBoard.appendChild(cell);
        }
    }
}

function renderNumberPad() {
    numberPad.innerHTML = "";

    for (let number = 1; number <= 9; number++) {
        const button = document.createElement("button");

        button.textContent = number;

        button.addEventListener("click", () => {
            enterNumber(number);
        });

        numberPad.appendChild(button);
    }
}

function enterNumber(number) {
    if (!selectedCell) {
        alert("Please select a cell first!");
        return;
    }

    const { row, col } = selectedCell;

    if (puzzle[row][col] !== 0) {
        return;
    }

    if (solution[row][col] === number) {
        board[row][col] = number;
        renderBoard();
        checkWin();
    } else {
        mistakes++;
        mistakesElement.textContent = `${mistakes} / 3`;

        const cell = document.querySelector(
            `[data-row="${row}"][data-col="${col}"]`
        );

        cell.classList.add("wrong");

        if (mistakes >= 3) {
            alert("Game Over! Try a new game.");
        }
    }
}

function eraseCell() {
    if (!selectedCell) return;

    const { row, col } = selectedCell;

    if (puzzle[row][col] !== 0) return;

    board[row][col] = 0;
    renderBoard();
}

function checkWin() {
    const completed = board.every((row, rowIndex) =>
        row.every((value, colIndex) =>
            value === solution[rowIndex][colIndex]
        )
    );

    if (completed) {
        alert("Congratulations! You solved the Sudoku!");
        clearInterval(timerInterval);
    }
}

function startTimer() {
    clearInterval(timerInterval);

    timerInterval = setInterval(() => {
        seconds++;

        const minutes = Math.floor(seconds / 60);
        const remainingSeconds = seconds % 60;

        timerElement.textContent =
            `${String(minutes).padStart(2, "0")}:` +
            `${String(remainingSeconds).padStart(2, "0")}`;
    }, 1000);
}

function newGame() {
    board = puzzle.map(row => [...row]);
    selectedCell = null;
    mistakes = 0;
    seconds = 0;

    mistakesElement.textContent = "0 / 3";
    timerElement.textContent = "00:00";

    renderBoard();
    startTimer();
}

let timerInterval;

document.getElementById("erase").addEventListener("click", eraseCell);
document.getElementById("new-game").addEventListener("click", newGame);

renderNumberPad();
newGame();
