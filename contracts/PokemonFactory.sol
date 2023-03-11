// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    event CreatedPokemon(address indexed _from, uint _id, string _value);
    struct Pokemon {
        uint id;
        string name;
    }
    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    function createPokemon(string memory _name, uint _id) public {
        require(_id> 0, "ID must be bigger than 0");
        bytes memory nameReq = bytes(_name);
        require(nameReq.length > 2, "Name must have at least 2 chars");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit CreatedPokemon(msg.sender, _id, "New pokemon created");
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getResult() public pure returns (uint product, uint sum) {
        uint a = 1;
        uint b = 2;
        product = a * b;
        sum = a + b;
    }
}
