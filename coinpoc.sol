pragma solidity ^0.4.20;

contract MinhaMoeda {
    //address: armazena 20 bytes (tamando de um endereço Ethereum)
    //mapping é uma estrutura de dados que relaciona uma chave à um valor 
    mapping(address => uint256) balances;
    uint256 totalSupply_;
    string public constant name = "CoinPoc";
    string public constant symbol = "CP";
    uint8 public constant decimals = 18;

    constructor() public {
        //totalSupply_ determina a quantidade de tokens em circulação. 
        totalSupply_ = 100 * (10 ** uint256(decimals));
        //balances vincula o saldo de cada endereço do dono de tokens.
        balances[msg.sender] = totalSupply_;
    }

    //O modificador view indica que a função é somente leitura 
    function totalSupply() public view returns (uint256) {    
        return totalSupply_;  
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];  
    }

    //Função para o envio de tokens para outros endereços, como ela altera o estado do contrato
    //ele é executado através de uma transação ethereum, por isso usa-se o "msg.sender" e assim
    //obtemos o endereço da conta que está enviando
    function transfer(address _to, uint256 _value) public returns (bool) { 
        //Garante que o endereço é válido
        require(_to != address(0)); 
        //O rementente deve ter saldo suficiente para enviar  
        require(_value <= balances[msg.sender]); 
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
    }
}