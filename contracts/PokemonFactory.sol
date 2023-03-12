// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    event CreatedPokemon(address indexed _from, uint _id, string _value);
    struct PokemonSkills {
        string Name;
        string Description;
    }
    struct Pokemon {
        uint id;
        string name;
    }
    Pokemon[] private pokemons;
    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;
    mapping(uint => mapping(uint => PokemonSkills)) public pokemonSkills;
    mapping(uint => mapping(uint => string)) public pokemonTypes;
    mapping(uint => mapping(uint => string)) public pokemonWeaknesses;

    function createPokemon(string memory _name, uint _id) public {
        require(_id > 0, "ID must be bigger than 0");
        bytes memory nameReq = bytes(_name);
        require(nameReq.length > 2, "Name must have at least 2 chars");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit CreatedPokemon(msg.sender, _id, "New pokemon created");
    }
    function addSkill(
        string memory _skillName,
        string memory _skillDesc,
        uint _id,
        uint _skillnumber
    ) public {
        require(_id > 0, "ID must be bigger than 0");
        require(_skillnumber > 0, "Skill number must be bigger than 0");
        bytes memory name = bytes(_skillName);
        require(name.length > 2, "Input a valid skill name, at least 2 chars");
        bytes memory desc = bytes(_skillDesc);
        require(
            desc.length > 10,
            "Input a valid skill description, at least 10 chars"
        );
        require(pokemonExists(_id), "Id does not exist");
        require(
            !pokemonSkillExist(_id, _skillnumber),
            "This skill exists already"
        );
        pokemonSkills[_id][_skillnumber] = PokemonSkills(
            _skillName,
            _skillDesc
        );
    }
    function addType(string memory _type, uint _id, uint _typeNumber) public {
        require(_id > 0, "ID must be bigger than 0");
        require(_typeNumber > 0, "Type number must be bigger than 0");
        bytes memory pokType = bytes(_type);
        require(
            pokType.length > 2,
            "Input a valid type name, at least 2 chars"
        );
        require(pokemonExists(_id), "Id does not exist");
        require(
            !pokemonTypeExist(_id, _typeNumber),
            "This type exists already"
        );
        pokemonTypes[_id][_typeNumber] = _type;
    }
    function addWeakness(string memory _weakness, uint _id, uint _weakNumber) public {
        require(_id > 0, "ID must be bigger than 0");
        require(_weakNumber > 0, "Weakness number must be bigger than 0");
        bytes memory weakness = bytes(_weakness);
        require(
            weakness.length > 2,
            "Input a valid weakness name, at least 2 chars"
        );
        require(pokemonExists(_id), "Id does not exist");
        require(
            !pokemonWeaknessExist(_id, _weakNumber),
            "This weakness exists already"
        );
        pokemonWeaknesses[_id][_weakNumber] = _weakness;
    }
    function pokemonExists(uint _id) internal view returns (bool) {
        address owner = pokemonToOwner[_id];
        return owner != address(0);
    }

    function pokemonSkillExist(
        uint _id,
        uint _skillNumber
    ) internal view returns (bool) {
        PokemonSkills memory skill = pokemonSkills[_id][_skillNumber];
        if (
            bytes(skill.Name).length == 0 &&
            bytes(skill.Description).length == 0
        ) {
            return false;
        }
        return true;
    }
    function pokemonTypeExist(
        uint _id,
        uint _typeNumber
    ) internal view returns (bool) {
        string memory pokType = pokemonTypes[_id][_typeNumber];
        if (bytes(pokType).length == 0) {
            return false;
        }
        return true;
    }
    function pokemonWeaknessExist(
        uint _id,
        uint _weaknessNumber
    ) internal view returns (bool) {
        string memory weakness = pokemonWeaknesses[_id][_weaknessNumber];
        if (bytes(weakness).length == 0) {
            return false;
        }
        return true;
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
