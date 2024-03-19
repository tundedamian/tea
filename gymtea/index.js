// index.js
function printTeaCup(cups) {
    const cup = `
     ( (
      ) )
    ........
    |      |]
    \\      /   
     \`----'
    `;
    for (let i = 0; i < cups; i++) {
        console.log(cup);
    }
}

module.exports = printTeaCup;
