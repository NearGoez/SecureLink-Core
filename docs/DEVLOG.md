# 🛡️ SeniorLink Development Log

**Start Date:** December 19, 2025
**Target Deadline:** December 31, 2025
**Goal:** Create a secure, self-hosted remote assistance tool for Android using Kotlin, Python, and gRPC.

---

## 🚩 Milestone 1: PKI Infrastructure & Protocol Design
**Focus:** OpenSSL, Certificate Authority, gRPC Proto definitions.

### 📅 [2025-12-19] - Setup & Certificates
* **Status:** [In Progress]
* **Context:** Establishing the Root CA to sign Client and Server certificates for mTLS.
* **Technical Challenges & Fixes:**
    * *Issue:* (Example) OpenSSL kept rejecting the config file for the v3 extensions.
    * *Solution:* Created a specific `openssl.cnf` adding `basicConstraints=CA:FALSE` for the leaf certificates.
    * *Command Used:* `openssl x509 -req ...`
* **Artifacts:**
    * [ ] `rootCA.crt` generated.
    * [ ] `server.crt` (for Android) signed.
    * [ ] `client.crt` (for PC) signed.

### 📅 [YYYY-MM-DD] - gRPC Proto Definition
* **Status:** [Pending]
* **Context:** Defining the contract between Python (Client) and Kotlin (Server).
* **Decisions:**
    * Chose `stream Frame` for screen sharing instead of sending raw bytes repeatedly to reduce overhead.
    * Added `Ping` RPC for health checks.

---

## 🚩 Milestone 2: Android Agent (The Server)
**Focus:** Kotlin, Foreground Services, Netty Server (gRPC).

### 📅 [YYYY-MM-DD] - Service Implementation
* **Status:** [Pending]
* **Context:** Running gRPC server on Android without getting killed by the OS.
* **Technical Challenges & Fixes:**
    * *Issue:* Android blocks non-SSL gRPC on newer API levels.
    * *Solution:* Enforced TLS credentials on the `NettyServerBuilder`.
* **Notes:** Need to check battery optimization permissions.

---

## 🚩 Milestone 3: Accessibility & Control
**Focus:** AccessibilityService API, Gesture Injection.

### 📅 [YYYY-MM-DD] - Gesture Injection
* **Status:** [Pending]
* **Context:** Translating gRPC `Tap` commands into Android system events.
* **Troubleshooting:**
    * *Note:* Coordinate mapping between PC resolution and Phone resolution needs a normalization factor (0.0 to 1.0).

---

## 🚩 Milestone 4: Python Client & GUI
**Focus:** PyQt6, mTLS Channel, Asyncio.

### 📅 [YYYY-MM-DD] - Client Connectivity
* **Status:** [Pending]
* **Context:** Connecting Python stub to the Android secure port.
* **Technical Challenges & Fixes:**
    * *Issue:* Python `grpcio` failing to validate self-signed CA.
    * *Solution:* Passed the root CA contents directly to `ssl_channel_credentials`.

---

## 📝 General Notes / Ideas for v2