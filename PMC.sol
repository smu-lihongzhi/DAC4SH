pragma solidity ^0.5.8;

contract PMC
{
	struct Policy{    // 
        string subjectId; //hash value 
        string objectId;  //hash value
        string action;  // read (r); write (w); no (n)  
		bool isUsed;
	}
	
	mapping(string=>Policy) public policyList;
	
	string[] indexes;   
	
	uint length = 0;
	
	
	function addPolicy(string memory subjectId,string memory objectId,string memory action,string memory record_hash) public{
		if (policyList[record_hash].isUsed){ //updating
			policyList[record_hash].subjectId = subjectId;
			policyList[record_hash].objectId = objectId;
			policyList[record_hash].action = action;
		}else{ //adding
			Policy memory policy_info_item = Policy(subjectId,objectId,action,true);
			policyList[record_hash] = policy_info_item;
			indexes.push(record_hash);
			length++;
		}
	}
	
	
	function deletePolicy(string memory record_hash) public returns (bool) {
		if (policyList[record_hash].isUsed){
			policyList[record_hash] = Policy("","","",false);
			return true;
		}
		return false;
	}
	
	
	function getPolicyInstance (string memory record_hash) public view returns (string memory,string memory,string memory){
		Policy memory item = policyList[record_hash];
		return (item.subjectId,item.objectId,item.action);
	}
	
	
	// Retrieving policies through objectid and subjectid
	function getPolicyInstanceByID (string memory subjectId, string memory objectId) public view returns (string memory,string memory,string memory) {
		string memory j;
		Policy memory item;
		for(uint i=0; i<length; i++){ 
			j = indexes[i];
			item = policyList[j];   
			if (keccak256(abi.encodePacked(item.subjectId)) == keccak256(abi.encodePacked(subjectId))){ //string compare method
				if (keccak256(abi.encodePacked(item.objectId)) == keccak256(abi.encodePacked(objectId))){
					return(item.subjectId,item.objectId,item.action);
				}
			}
		}
		return ("","","");
	}
	
	//verify access rights
	function verifyRights(string memory subjectId, string memory objectId, string memory action) public view returns (string memory, bool){
		string memory msg;
		bool ret;
		(string memory sId,string memory oId,string memory daction) = this.getPolicyInstanceByID(subjectId,objectId);
		if (keccak256(abi.encodePacked(daction))==keccak256(abi.encodePacked(action))){
			msg = "Yes,get permissions successfully!";
			ret = true; 
		}else{
			msg ="No, get permissions failed!";
			ret = false;
		}
		return (msg,ret);
	
	
	}
	
	
	
	
	


}