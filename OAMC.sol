pragma solidity ^0.5.8;
contract OAMC
{
	struct Object{   // 
        string name;
        string org;
        string place;   //
        string dep; //
		bool isUsed;
	}
	
	mapping(string=>Object) public objList;
	
	function addObject(string memory name,string memory org,string memory place, string memory dep, string memory record_hash) public{
		if (objList[record_hash].isUsed){ //updating
			objList[record_hash].name = name;
			objList[record_hash].org = org;
			objList[record_hash].place = place;
			objList[record_hash].dep = dep;
		}else{ //adding
			Object memory object_info_item = Object(name,org,place,dep,true);
			objList[record_hash] = object_info_item;
		}
	}
	
	
	function deleteObject(string memory record_hash) public returns ( bool ){
		if (objList[record_hash].isUsed){
			objList[record_hash] = Object("","","","",false);
			return true;
		}
		return false;
	}
	
	function getObjectInstance (string memory record_hash) public view returns (string memory,string memory,string memory,string memory){
		Object memory item = objList[record_hash];
		return (item.name,item.org,item.place,item.dep);
	}



}