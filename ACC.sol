pragma solidity ^0.5.8;

contract SAMC{
	function getSubjectInstance (string memory record_hash) public view returns (string memory,string memory,string memory)
}

contract PMC{
	function getPolicyInstance (string memory record_hash) public view returns (string memory,string memory,string memory);
	function getPolicyInstanceByID (string memory subjectId, string memory objectId) public view returns (string memory,string memory,string memory);
}

contract OAMC{
	function getObjectInstance (string memory record_hash) public view returns (string memory,string memory,string memory,string memory);
}

contract ACC{
	function accessControl(string memory s_record_hash,string memory o_record_hash, string memory action) public view returns (string memory, bool memory){
		string memory msg;
		bool memory ret;
		(string memory sname,string memory sorg,string memory splace)=SAMC.getSubjectInstance(s_record_hash);
		(string memory oname,string memory oorg, string memory oplace)=OAMC.getSubjectInstance(o_record_hash);
		if (sname.length ==0 || oname.length==0){
			msg="object or subject is not found";
			ret = false;
			return (msg,ret);
		}
		(string memory sId,string memory oId, string memory daction) = getPolicyInstanceByID(s_record_hash,o_record_hash);
		if (keccak256(abi.encodePacked(daction))==keccak256(abi.encodePacked(action))){{
			msg = "Yes,get permissions successfully!";
			ret = true; 
		}else{
			msg ="No, get permissions failed!";
			ret = false;
		}
		return (msg,ret);
	}	


}