pragma solidity ^0.5.0;

contract SocialNetwork {
    string public name;
    uint public postCount=0;
    mapping(uint=>Post)public posts;

    struct Post{
        uint id;
        string content;
        uint tipAmount;
        address payable author;
    }

    event PostCreated(uint id, string content, uint tipAmount, address payable author);
    event PostTipped(uint id, string content, uint tipAmount,  address payable author);

    constructor() public{
        name='Social Network';
    }

    function createPost(string memory content) public {
        require(bytes(content).length>0);

        postCount++;
        posts[postCount]=Post(postCount,content,0,msg.sender);

        emit PostCreated(postCount,content,0,msg.sender);
    }

    function tipPost(uint id) public payable{

        require(id>0 && id<=postCount);

        Post memory post= posts[id];

        address payable author=post.author;
        address(author).transfer(msg.value);
        post.tipAmount=post.tipAmount + msg.value;

        posts[id]=post;

        emit PostTipped(postCount,post.content,post.tipAmount,post.author);
    }

    
}
