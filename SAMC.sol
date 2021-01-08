pragma solidity ^0.5.8;
contract SAMC
{
	struct Subject{    // 
        string name;
        string org;
        string place;  //
		bool isUsed;
	}
	
	mapping(string=>Subject) public subList;
	
	function addSubject(string memory name,string memory org,string memory place,string memory record_hash) public{
		if (subList[record_hash].isUsed){ //updating
			subList[record_hash].name = name;
			subList[record_hash].org = org;
			subList[record_hash].place = place;
		}else{ //adding
			Subject memory subject_info_item = Subject(name,org,place,true);
			subList[record_hash] = subject_info_item;
		}
	
	}
	
	
	function deleteSubject (string memory record_hash) public returns ( bool ){
		if (subList[record_hash].isUsed){
			subList[record_hash] = Subject("","","",false);
			return true;
		}
		return false;
	}
	
	
	function getSubjectInstance (string memory record_hash) public view returns (string memory,string memory,string memory){
		Subject memory item = subList[record_hash];
		return (item.name,item.org,item.place);
	}
	
}