# Archethought Mobile App Requirements Document

## Table of Contents

1. **Introduction**
   1.1. Purpose
   1.2. Target Audience
   1.3. Overview
2. **User Needs**
   2.1. Understanding the Elderly Users
   2.2. Challenges Faced by the Elderly
3. **App Features**
   3.1. Personal Village Concept
   3.2. Member Directory
   3.3. Communication Features
   3.4. Knowledge Library
4. **Use Cases**
   4.1. Use Case 1: Connecting with Family and Friends
   4.2. Use Case 2: Seeking Professional Assistance
   4.3. Use Case 3: Accessing Essential Services
5. **Technical Requirements**
   5.1. Platform Compatibility
   5.2. Security and Privacy (PASS)
   5.3. Accessibility
   5.4. Scalability

## 1. Introduction

### 1.1. Purpose

The purpose of this document is to outline the requirements for the development of a mobile app designed to support vulnerable senior women by creating a personalized support network, referred to as a "Personal Village." This app aims to enhance the quality of life for elderly individuals by facilitating easy communication, providing access to a knowledge library, and fostering a sense of community and support.

### 1.2. Target Audience

The primary audience for this mobile app is vulnerable senior women who may lack experience with technology or have accessibility issues. The app is designed to be user-friendly and accessible to individuals with varying levels of technological expertise.

### 1.3. Overview

The app's core concept is to empower elderly users to form a Personal Village of helpers, including family, friends, caregivers, and professionals. This Village will provide support through accessible communications, a directory of members, and a knowledge library. The goal is to create a strong sense of community, knowledge-sharing, and assistance for the elderly.

## 2. User Needs

### 2.1. Understanding the Elderly Users

To effectively address the needs of elderly users, it is essential to recognize their unique challenges and requirements. These challenges may include limited technological experience, accessibility issues, and a need for simplified user interfaces.

### 2.2. Challenges Faced by the Elderly

- Limited technology skills
- Accessibility issues, including visual or hearing impairments
- Desire for simplified, user-friendly interfaces
- Limited mobility and potential physical limitations

## 3. App Features

### 3.1. Personal Village Concept

The app will revolve around the Personal Village concept, allowing users to:

- Invite and manage members of their Village
- Define access rights for each member
- Facilitate communication and collaboration within the Village

### 3.2. Member Directory

To enable users to build, maintain, and visualize their Village, the app will include:

- Directory API for adding and managing Village members (provided by Archethought)
- User-friendly visualization of Village members and their statuses

### 3.3. Communication Features

The app will support seamless communication through:

- Email and chat-like features for private conversations
- Searchable communication history to facilitate easy retrieval of information

### 3.4. Knowledge Library

To provide essential knowledge and resources, the app will offer:

- A searchable library containing information on accessing essential services
- Additional knowledge resources to help users thrive

## 4. Use Cases

### 4.1. Use Case 1: Connecting with Family and Friends

**Scenario:** An elderly user, Mary, wants to connect with her daughter, Sarah, and her closest friend, Jane, to share updates and seek assistance when needed. Mary opens the app, selects Sarah and Jane from her Village, and sends them a message.

### 4.2. Use Case 2: Seeking Professional Assistance

**Scenario:** John, an elderly user, requires professional assistance from a caregiver. He accesses the app, searches for caregivers in his Village, and initiates communication to schedule assistance.

### 4.3. Use Case 3: Accessing Essential Services

**Scenario:** Emma, an elderly user, needs information on local resources for grocery delivery. She uses the app's knowledge library to search for available services and finds relevant information.

## 5. Technical Requirements

### 5.1. Platform Compatibility

The app should be compatible with both mobile and desktop devices, ensuring a consistent user experience across platforms.

### 5.2. Security and Privacy (PASS)

Robust security measures must be implemented to protect user data and ensure privacy within the app.

#### Basic Requirements
- Encrypted document storage for personal attributes like health records, finances, identity docs
- Attribute access controlled through permissions-based question/answer system
- Questions require credentials to ask, attributes revealed based on permissions
- Compliant with healthcare privacy regulations (HIPAA)
- Consent flows for sharing attributes with Personal Village members or public services
- User-managed permissions including ability to revoke access
- Backed up externally to prevent data loss
- Open document formats, such as Markdown and PNG

#### Use Cases

- Joan grants doctors one-time access to medical history to assist diagnosis
- Emma permits social worker to view disability status when applying for benefits
- Frank allows pharmacy to check prescription history for drug interactions
- Linda shares allergy info with her Care Team but no one else
- An EMT "breaks the glass" and invokes the emergency mode to access key health data

#### Personas

The personas value privacy and control over personal information. PASS gives them granular control over what details are revealed, and to whom. This is balanced against the need for selective sharing with care providers.

#### Public Services

Use credentialed questions to request minimum info needed to determine eligibility and deliver services. Consent flows allow one-time access. Complies with local data regulations.

#### Implementation

PASS will be a core infrastructure but should be abstracted away from users. Consent flows are incorporated into existing features. Villagers can, for example, manage sharing from their profile, or during a normal dialog as part of the everyday use of the app.

### 5.3. Accessibility

The app should adhere to accessibility standards to accommodate users with disabilities, including features for visual and hearing impairments.

### 5.4. Scalability

The app should be designed to scale as the user base grows, ensuring a smooth user experience even with a large number of users.
