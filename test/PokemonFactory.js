const {expect} = require("chai");

describe("Pokemon Factory Contract", function (){
  it("Pokemon Factory Should create pokemons ", async function() {
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const hardhatPokemon = await PokemonFactory.deploy();
    const pokemons = await hardhatPokemon.getAllPokemons();
    expect(pokemons.length).to.equal(0);
  });
  
})