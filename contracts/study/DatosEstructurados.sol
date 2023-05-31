// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Clase {
    
    enum Gender {FEMALE, MALE, NOBINARY}
    
    struct Alumno {
        string nombre;
        uint documento;
        Gender gender;
    }
    
    Alumno[] public alumnos;
    mapping(string => uint) public notes;
    
    constructor() {
        alumnos.push(Alumno({ nombre: "Miguel", documento: 66666, gender: Gender.MALE}));
        notes["Miguel"] = 100;
    }
    
}