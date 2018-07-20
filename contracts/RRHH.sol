pragma solidity ^0.4.23;
import "./Oraclize.sol";
//import "./oraclizeAPI.sol";

contract RRHH is usingOraclize {

    uint public prueba;
    string public ETHXBT; 
    string public texto;
    address private onwer;
    struct course
    {
        address provider;
        string IdCourse;
        string description;
        bool validated;
        /*uint date;
        uint expirationDate;
        string contact;
        bool validated;
        address holder;*/
    }

    course[] AuthoridedCourses;

    course[] public courses;
    event LogConstructorInitiated(string nextStep);
    event LogPriceUpdated(string price);
    event LogNewOraclizeQuery(string description);

    constructor() public  {

        onwer = msg.sender;
        prueba = 12;
        OAR = OraclizeAddrResolverI(0x490D46E5ef3DC3D8557660d8129932910053cf4b);
        
    }

    function getPrueba() public   returns(uint) {

        /*courses[0].date = 12;
        return courses[0].date;*/
        
        return prueba;
    }

    function  __callback (bytes32 myid, string result)  {
        if (msg.sender != oraclize_cbAddress()) revert();
        ETHXBT = result;
    }

    function getratio() public payable {

        address pagador = msg.sender;
        uint balance = msg.value;
        if (oraclize_getPrice("URL") > balance) {
            emit LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHXBT).result.XETHXXBT.c.0");
            }
    }

    function getValor () public view returns(string) {

        return ETHXBT;
    }

    function add() public {

        prueba = prueba + 1;
    }

    function minus() public {

        prueba = prueba - 1;
    }

    function getOwner() public view returns(address) {
        return onwer;
    }

    function addCourse(string _idCourse,  string _description) public {
    // int8 _note, uint _expirationDate, string _idCourse) public  {

        course memory AuxAuthoridedCourse; 
        AuxAuthoridedCourse = course(msg.sender,_idCourse,_description,true);
        AuthoridedCourses.push(AuxAuthoridedCourse);
    }

    function lookForMyCourses(uint i) public view returns(string, bool, address, string){



        /*for(i = 0; i <= courses.length; i++) {
            if (courses[i].provider == msg.sender){
                auxCourses = courses[i];
                break;
            }*/

            
        
        return (AuthoridedCourses[i].description,AuthoridedCourses[i].validated,AuthoridedCourses[i].provider, AuthoridedCourses[i].IdCourse);

        

    }

    function getNumberOfCourses() public view returns (uint) {

        return AuthoridedCourses.length;
    }
    
}