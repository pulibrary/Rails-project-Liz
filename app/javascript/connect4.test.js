import '@testing-library/jest-dom/extend-expect';
import { screen, fireEvent } from '@testing-library/dom';

context('test connect4 game', () => {

  it('calls setGame, should have unmarked board', () => {
        setGame();
        check = true
        for(let r = 0; r < 6; r++) {
            for(let c = 0; c < 7; c++) {
                var tile = screen.getById(`${r}-${c}`)
                if (tile != ' ') {
                    check = false
                }
            }
        }
        expect(check).toBe(true)
    });


    // it('presses a title, should be marked with currPlayer\'s color', () => {
    //     // Get the tile element by its ID
    //     const tile = screen.getById('tile-0-0');
    //     // Simulate a click event
    //     fireEvent.click(tile);

    
    //     // expect(someOtherElement).toBeVisible();
    // });
});


