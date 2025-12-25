// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrustChain {
    struct PredictionLog {
        string domain;
        string inputHash;
        string prediction;
        string confidence;
        string modelVersion;
        uint256 timestamp;
        address verifier;
    }

    PredictionLog[] public logs;
    mapping(string => bool) public existingHashes;

    event LogAdded(string domain, string prediction, string confidence, uint256 timestamp);

    function addLog(
        string memory _domain,
        string memory _inputHash,
        string memory _prediction,
        string memory _confidence,
        string memory _modelVersion
    ) public {
        logs.push(PredictionLog({
            domain: _domain,
            inputHash: _inputHash,
            prediction: _prediction,
            confidence: _confidence,
            modelVersion: _modelVersion,
            timestamp: block.timestamp,
            verifier: msg.sender
        }));

        existingHashes[_inputHash] = true;
        emit LogAdded(_domain, _prediction, _confidence, block.timestamp);
    }

    function getLogsCount() public view returns (uint256) {
        return logs.length;
    }

    function getLog(uint256 _index) public view returns (
        string memory, string memory, string memory, string memory, uint256
    ) {
        PredictionLog memory log = logs[_index];
        return (log.domain, log.prediction, log.confidence, log.modelVersion, log.timestamp);
    }
}
