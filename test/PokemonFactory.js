const {expect} = require("chai");

describe("Pokemon Factory Contract", function (){
  it("Pokemon Factory count 0 pokemons ", async function() {
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const hardhatPokemon = await PokemonFactory.deploy();
    const pokemons = await hardhatPokemon.getAllPokemons();
    console.log(pokemons);
    expect(pokemons.length).to.equal(0);
  });
  it("Pokemon Factory Should create pokemons ", async function() {
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const hardhatPokemon = await PokemonFactory.deploy();
    const skills = [
      {
        Name : "skill1", 
        Description : "This is a test description for pokemon creation"
      },
      {
        Name : "skill2", 
        Description : "This is a second test description for pokemon creation"
      }
    ]
    const pokemons = await hardhatPokemon.createPokemon("test1", 1, skills);
    console.log(pokemons);
    const getPokemonst = await hardhatPokemon.getAllPokemons();
    expect(getPokemonst.length).to.equal(1);
  });
})