# Tokenized Healthcare Clinical Trial Management System

A blockchain-based system for managing clinical trials using Clarity smart contracts.

## Overview

This system provides a secure, transparent, and immutable way to manage healthcare clinical trials on the blockchain. It includes verification of research institutions, protocol registration, patient enrollment, data collection, and adverse event tracking.

## Smart Contracts

### 1. Institution Verification (`institution-verification.clar`)
Validates and verifies research entities that can participate in clinical trials.

**Key Functions:**
- `verify-institution`: Add a new verified institution
- `is-verified`: Check if an institution is verified
- `get-institution-details`: Get details about a verified institution
- `revoke-verification`: Remove verification from an institution

### 2. Protocol Registration (`protocol-registration.clar`)
Records study methodologies and protocols for clinical trials.

**Key Functions:**
- `register-protocol`: Register a new clinical trial protocol
- `get-protocol`: Get details about a registered protocol
- `update-protocol-status`: Update the status of a protocol

### 3. Patient Enrollment (`patient-enrollment.clar`)
Manages participant consent and enrollment in clinical trials.

**Key Functions:**
- `enroll-patient`: Enroll a patient in a clinical trial
- `update-enrollment-status`: Update a patient's enrollment status
- `get-enrollment-status`: Check a patient's enrollment status

### 4. Data Collection (`data-collection.clar`)
Securely stores trial results and data points.

**Key Functions:**
- `record-data-point`: Record a new data point for a patient
- `get-data-point`: Get a specific data point
- `update-data-point-status`: Update the status of a data point

### 5. Adverse Event Tracking (`adverse-event-tracking.clar`)
Records safety incidents and their resolution.

**Key Functions:**
- `report-adverse-event`: Report a new adverse event
- `get-adverse-event`: Get details about an adverse event
- `update-adverse-event`: Update the status and resolution of an adverse event

## Security Features

- All contracts implement proper access controls
- Patient data is stored as hashes to maintain privacy
- Only verified institutions can register protocols
- Only protocol owners can enroll patients and record data

## Getting Started

### Prerequisites
- Clarity language support
- Stacks blockchain environment

### Installation
1. Clone this repository
2. Deploy the contracts in the following order:
    - institution-verification.clar
    - protocol-registration.clar
    - patient-enrollment.clar
    - data-collection.clar
    - adverse-event-tracking.clar

### Usage Example

```clarity
;; Verify a research institution
(contract-call? .institution-verification verify-institution 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG "Research Hospital" u2)

;; Register a protocol
(contract-call? .protocol-registration register-protocol .institution-verification "Cancer Treatment Trial" "A study of new cancer treatments" 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef)

;; Enroll a patient
(contract-call? .patient-enrollment enroll-patient .protocol-registration u1 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef 0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890)
