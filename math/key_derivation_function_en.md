---
title: "Key Derivation Function"
date: 2016-10-28
description: "Key Derivation Function"
math: true
translated_by_ai: true
translated_from: "nl"
original: "key_derivation_function_nl.md"

---


# Key Derivation Function (KDF)

## Cryptographic Key Derivation

> **Cryptography | Key Management | Password Security**

A **Key Derivation Function (KDF)** is a cryptographic algorithm used to derive one or more secret keys from an existing secret value.

This original value may be a master key, password, passphrase, or another form of secret key material.

KDFs are fundamental components of modern cryptographic systems and are widely used for encryption, authentication, password protection, and secure key management.

---

## 1. How a Key Derivation Function Works

A KDF typically uses a pseudorandom function based on a cryptographic hash function or a block cipher.

Its purpose is to generate new cryptographic keys from existing secret material.

### Main Applications

- **Key derivation:** Generate multiple cryptographic keys from a single master key.
- **Key separation:** Prevent different applications from using the same cryptographic key.
- **Password security:** Transform passwords into values suitable for secure storage or cryptographic operations.
- **Key stretching:** Deliberately increase computational costs to make brute-force attacks more difficult.
- **Key exchange:** Transform shared secrets into cryptographic keys.
- **Key management:** Independently derive keys for different purposes.

### Simplified Architecture

```text
                  +------------------+
                  |   Master Secret  |
                  |   or Password    |
                  +---------+--------+
                            |
                            v
                  +------------------+
                  |       KDF        |
                  |                  |
                  |  Salt / Context  |
                  |  Parameters      |
                  +---------+--------+
                            |
              +-------------+-------------+
              |             |             |
              v             v             v
         +---------+   +---------+   +---------+
         | Key A   |   | Key B   |   | Key C   |
         +---------+   +---------+   +---------+
```

A properly designed KDF should ensure that compromising one derived key does not reveal the original secret or other independently derived keys.

---

## 2. Key Derivation and Key Diversification

An important application of KDFs is **key diversification**.

This technique derives multiple cryptographic keys from a single shared secret.

It prevents the same key from being reused for different cryptographic purposes.

### Example

Suppose a system maintains a single master key:

```text
Master Key
    |
    +----> KDF(context="encryption") -----> Encryption Key
    |
    +----> KDF(context="authentication") -> Authentication Key
    |
    +----> KDF(context="session") --------> Session Key
```

Each derived key serves a specific purpose.

This principle is known as **cryptographic domain separation**.

By using different context values, cryptographic keys can be derived independently.

### Advantages

1. A single master key can support multiple cryptographic applications.
2. Different applications do not need to share the same key.
3. The risk of unintended key reuse is reduced.
4. Key management becomes easier.
5. Cryptographic protocols can use independent keys for different operations.

---

## 3. Key Stretching and Key Strengthening

Human-generated passwords typically contain insufficient entropy to serve directly as strong cryptographic keys.

For example, a password such as:

```text
MyPassword123
```

may be relatively easy to guess when an attacker has sufficient computational resources.

One technique used to mitigate this problem is **key stretching**.

### What Is Key Stretching?

Key stretching deliberately increases the computational cost of deriving a cryptographic value from a password.

This is achieved by requiring additional processing time, memory consumption, or both.

A simplified representation is:

```text
DerivedKey = KDF(password, salt, parameters)
```

Where:

| Parameter | Description |
|---|---|
| `DerivedKey` | The resulting cryptographic key |
| `KDF` | The key derivation function |
| `password` | The original password |
| `salt` | A random value |
| `parameters` | Settings controlling computational cost, memory usage, or parallelism |

### Why Is This Important?

When an attacker attempts to recover a password, the KDF must be executed for every password candidate.

A conventional cryptographic hash function can be calculated extremely quickly.

A password-specific KDF, however, can require significantly more processing time and memory.

This makes large-scale brute-force attacks more expensive.

> [!IMPORTANT]
> Key stretching does not increase the original entropy of a password. It increases the cost of testing password candidates, but it does not transform a weak password into a genuinely random secret.

---

## 4. The Role of a Salt

A **salt** is a random value incorporated into the process of deriving a cryptographic value from a password.

Its primary purpose is to ensure that identical passwords do not automatically produce identical derived values.

### Without a Salt

```text
Password: secret123
       |
       v
      Hash
       |
       v
  Hash Value
```

If two users have the same password, applying the same hash function produces identical hash values.

### With a Salt

```text
Password: secret123       Password: secret123
Salt:     A7F2            Salt:     B9C4
       |                         |
       v                         v
      KDF                       KDF
       |                         |
       v                         v
   DerivedKey A              DerivedKey B
```

Although both users have identical passwords, the resulting derived values differ.

### Properties of a Salt

- A salt should be generated using a cryptographically secure random number generator.
- A new salt should be generated for each password record.
- A salt does not need to remain secret.
- A salt can be stored alongside the derived value.
- A salt prevents the straightforward reuse of precomputed lookup tables, including rainbow tables.

> [!NOTE]
> A salt is not a substitute for a strong password or a secure password hashing algorithm.

---

## 5. Deriving Keys from Passwords

Conventional cryptographic hash functions, such as SHA-256 and SHA-512, are designed to operate quickly and efficiently.

For many cryptographic applications, this is desirable.

However, when protecting passwords, this speed becomes a disadvantage.

An attacker who obtains a database of password hashes may use powerful hardware to test enormous numbers of password candidates.

Specialized password hashing and key derivation algorithms were developed to address this problem.

### Common Algorithms

| Algorithm | Characteristics | Primary Application |
|---|---|---|
| PBKDF2 | Configurable iteration count | Password-based key derivation |
| bcrypt | Configurable computational cost | Password hashing |
| scrypt | Memory-hard algorithm | Password hashing and key derivation |
| Argon2 | Configurable memory and computational costs | Password hashing |
| Argon2id | Combines properties of Argon2i and Argon2d | Modern password security |
| HKDF | Efficient HMAC-based key derivation | Cryptographic key management |

### Important Distinction

Not every KDF is designed for passwords.

**HKDF**, for example, is suitable for deriving cryptographic keys from secret material containing sufficient entropy.

**Argon2id**, on the other hand, is specifically designed to make password guessing computationally expensive.

These algorithms are therefore not interchangeable.

---

## 6. PBKDF2

**Password-Based Key Derivation Function 2 (PBKDF2)** is a widely used standard for deriving cryptographic keys from passwords.

PBKDF2 uses a pseudorandom function, typically based on HMAC.

### How It Works

PBKDF2 combines:

1. A password.
2. A salt.
3. A configurable number of iterations.
4. A desired output key length.

Example:

```text
PBKDF2(
    password,
    salt,
    iterations,
    key_length
)
```

### Advantages

- Widely supported.
- Standardized.
- Suitable for environments with specific compliance requirements.
- Relatively straightforward to implement using established cryptographic libraries.

### Disadvantages

PBKDF2 is primarily computationally intensive and requires relatively little memory.

As a result, specialized GPUs and other hardware can execute many calculations in parallel.

Modern memory-hard algorithms such as Argon2id generally provide stronger resistance to large-scale parallel password guessing attacks.

---

## 7. scrypt

**scrypt** is a key derivation function designed to require substantial memory in addition to computational processing.

The algorithm uses memory-intensive calculations.

### Purpose

An attacker must allocate significant computational and memory resources for password-guessing operations.

This reduces the advantages of highly parallel hardware.

### Characteristics

- Configurable memory consumption.
- Configurable computational cost.
- Suitable for password hashing.
- Suitable for deriving cryptographic keys from passwords.

scrypt is a useful alternative when Argon2id is unavailable.

---

## 8. Argon2

Argon2 is a modern family of password hashing functions.

The algorithm was developed as part of the **Password Hashing Competition**.

The competition began in 2013 with the objective of selecting a modern standard for secure password processing.

On July 20, 2015, Argon2 was announced as the winner.

### Variants

Argon2 has three major variants.

| Variant | Characteristics |
|---|---|
| Argon2d | Data-dependent memory access |
| Argon2i | Data-independent memory access |
| Argon2id | Combines properties of Argon2i and Argon2d |

### Argon2id

Argon2id combines protection against different attack techniques.

The algorithm provides configurable parameters for:

- **Memory consumption:** The amount of memory required.
- **Computational cost:** The number of processing passes.
- **Parallelism:** The degree of parallel processing.

### Example

```text
Argon2id(
    password,
    salt,
    memory_cost,
    time_cost,
    parallelism
)
```

By carefully selecting these parameters, a system can balance security requirements against performance.

> [!TIP]
> For new applications requiring secure password storage, Argon2id is generally the recommended choice.

---

## 9. HKDF

**HMAC-based Key Derivation Function (HKDF)** is a cryptographic key derivation function based on HMAC.

HKDF is standardized in RFC 5869.

The algorithm derives cryptographic key material from an existing secret.

### Two Phases

HKDF consists of two main operations:

1. **Extract:** Process the initial key material into a pseudorandom key.
2. **Expand:** Generate one or more derived keys from that pseudorandom key.

### Architecture

```text
              Input Key Material
                      |
                      v
              +---------------+
              | HKDF-Extract  |
              +-------+-------+
                      |
                      v
             Pseudorandom Key
                      |
                      v
              +---------------+
              | HKDF-Expand   |
              +-------+-------+
                      |
                      v
                Derived Keys
```

### Applications

HKDF is used in:

- TLS 1.3.
- Cryptographic key exchange protocols.
- Session key derivation.
- Key separation within cryptographic protocols.

HKDF is not designed to protect weak human-generated passwords against brute-force attacks.

---

## 10. History of Password Hashing Functions

One of the earliest techniques for deliberately slowing down password processing was the Unix `crypt` function.

It was developed by Robert Morris in 1978.

The original implementation used a modified version of the DES encryption algorithm.

By performing repeated calculations, the function increased the computational cost of recovering passwords.

### Historical Development

| Period | Development |
|---|---|
| 1978 | Unix `crypt` using modified DES |
| 1990s | Development of bcrypt |
| 2000 | Publication of PBKDF2 in PKCS #5 |
| 2009 | Introduction of scrypt |
| 2013 | Start of the Password Hashing Competition |
| 2015 | Argon2 wins the competition |
| 2020s | Argon2id becomes widely recommended for new applications |

The development of powerful GPUs, FPGAs, and ASICs has made older password hashing methods increasingly vulnerable to large-scale attacks.

Modern algorithms attempt to address these developments by introducing configurable memory requirements and computational costs.

---

## 11. Security Recommendations

The choice of a key derivation function depends on its intended application.

### Password Hashing

For new applications, the generally recommended preference order is:

1. **Argon2id** — Recommended for modern password security.
2. **scrypt** — Suitable alternative when Argon2id is unavailable.
3. **bcrypt** — Primarily suitable for existing systems.
4. **PBKDF2** — Appropriate when specific FIPS compliance requirements apply.

### Cryptographic Key Derivation

For deriving multiple cryptographic keys from existing strong secret material, HKDF is often an appropriate choice.

### General Recommendations

- Use established and well-reviewed cryptographic libraries.
- Avoid developing custom cryptographic algorithms.
- Generate salts using cryptographically secure random number generators.
- Choose appropriate memory and computational cost parameters.
- Avoid reusing cryptographic keys for different purposes.
- Apply domain separation when deriving multiple keys.
- Regularly review and update cryptographic security parameters.
- Protect master keys and other sensitive key material against unauthorized access.

---

## 12. Conclusion

Key derivation functions are fundamental components of modern cryptography.

They enable systems to securely derive multiple cryptographic keys from a single secret, improve password protection, and generate cryptographic key material suitable for specific applications.

The most important distinction is between **password protection** and **cryptographic key derivation**.

For password protection, memory-hard algorithms such as Argon2id are generally appropriate.

For deriving cryptographic keys from existing strong secrets, HKDF is often a suitable choice.

Secure implementation requires more than selecting the correct algorithm. It also depends on appropriate parameters, sufficient entropy, proper domain separation, and careful key management.

---

## 13. References

### Wikipedia

- [Key derivation function](https://en.wikipedia.org/wiki/Key_derivation_function)
- [PBKDF2](https://en.wikipedia.org/wiki/PBKDF2)
- [scrypt](https://en.wikipedia.org/wiki/Scrypt)
- [Argon2](https://en.wikipedia.org/wiki/Argon2)
- [HKDF](https://en.wikipedia.org/wiki/HKDF)

### Technical Standards

- [RFC 5869 — HMAC-based Extract-and-Expand Key Derivation Function (HKDF)](https://www.rfc-editor.org/rfc/rfc5869)
- [RFC 8018 — PKCS #5: Password-Based Cryptography Specification](https://www.rfc-editor.org/rfc/rfc8018)
- [RFC 9106 — Argon2 Memory-Hard Function](https://www.rfc-editor.org/rfc/rfc9106)
- [RFC 7914 — The scrypt Password-Based Key Derivation Function](https://www.rfc-editor.org/rfc/rfc7914)

### Security Guidelines

- [OWASP — Password Storage Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)

---

