{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf830
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.4.21;\
\
contract SmartSponsor \{\
    string influencerName;\
    address influencerAccount;\
    string brandName;\
    string terms;\
    uint256 funds;\
    address bidder;\
    string bidStatus;\
    bool contractComplete;\
    \
    function set(string _influencerName, address _influencerAccount, string _brandName, string _terms) public \{\
        influencerName = _influencerName;\
        influencerAccount = _influencerAccount;\
        brandName = _brandName;\
        terms = _terms;\
    \}\
\
    function get() external constant returns (string,string,string) \{\
        return (influencerName,brandName,terms);\
    \}\
    \
    function submitBid() external payable \{\
        funds = msg.value;\
		bidder = msg.sender;\
		bidStatus = "Bid Submitted";\
	\}\
	\
	function getStatus() external constant returns (address,address,uint256) \{\
	    return (bidder,influencerAccount,funds);\
	\}\
	\
	function acceptBid() external returns (string, bool) \{\
        require(influencerAccount == msg.sender); \
            bidStatus = "Bid Accepted";\
            contractComplete = false;\
            return (bidStatus, contractComplete);\
	\}\
	\
	function completeWork() external returns (string, bool) \{\
        require(bidder == msg.sender);\
            contractComplete = true;\
            bidStatus = "Contract Complete";\
            return (bidStatus, contractComplete);\
	\}\
	\
	function payout() external returns (string) \{\
	        require(contractComplete == true && msg.sender == bidder);\
	        influencerAccount.transfer(address(this).balance);\
	        bidStatus = "Payout Complete!";\
	        return bidStatus;\
	    \}\
\}}