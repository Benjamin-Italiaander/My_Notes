Here’s a cleaned-up, clearer, and GitHub-friendly version of your text. I kept your intent but tightened the wording and fixed a few technical/grammar issues:

---

# Using `age` with a YubiKey (and Post-Quantum Notes)

## ⚠️ Post-Quantum Considerations

Using age with a YubiKey is **not post-quantum (PQ) secure**.

* Only manually generated age keys (depending on implementation/algorithm) can be considered PQ-resistant.
* You **cannot import an existing age identity (private key)** into a YubiKey.
* A YubiKey can only **generate and store its own keys**.

👉 If you are strictly aiming for **post-quantum–resistant encryption**, a YubiKey is currently **not the right tool**.

---

## 🔧 Requirements

You need additional tooling for YubiKey support:

```bash
sudo apt install pcscd
sudo systemctl enable --now pcscd
```

Install the `age` YubiKey plugin:

```bash
cargo install age-plugin-yubikey
```

> If you don’t have `cargo`, install Rust first (e.g. via `rustup`).

---

## 🔐 YubiKey Setup (PIV)

Before using your YubiKey, you **must secure it properly**.

### 1. Change the Management Key

⚠️ The default management key for all YubiKeys is:

```
010203040506070801020304050607080102030405060708
```

You **must change this immediately**.

#### Option A — Protected (recommended)

The YubiKey derives the management key from your PIN:

```bash
ykman piv access change-management-key --generate --protect
```

#### Option B — Manual Storage

The YubiKey generates a key, and you store it securely (offline, printed, QR, etc.):

```bash
ykman piv access change-management-key --generate
```

#### Example (Protected + Explicit Algorithm)

```bash
ykman piv access change-management-key -a TDES --protect
```

---

### 2. Change PIN and PUK

Default credentials:

* PIN: `123456`
* PUK: `12345678`

Change them:

```bash
ykman piv access change-pin
```

```bash
ykman piv access change-puk
```

---

## 🔑 Generate an `age` Identity on the YubiKey

You cannot import an existing identity, but you can generate one:

```bash
age-plugin-yubikey
```

Follow the interactive prompts.

This will create a file like:

```
age-yubikey-identity-*.txt
```

* The line starting with `Recipient:` is your **public key**.

---

## 🔍 Retrieve Public Keys

You can also list keys directly:

```bash
age-plugin-yubikey --list
```

* The **last line** contains your public key (long string).

---

## 🔒 Encrypting Files

You can encrypt files for **multiple recipients** (e.g. multiple YubiKeys + backup keys).

Example:

```bash
age -R ./yubikey1.pub -R ./yubikey2.pub -o file.txt.age file.txt
```

👉 Notes:

* You can include multiple recipients for redundancy/backups.
* The input file (`file.txt`) always comes **last**.
* Mixing PQ and non-PQ keys is **not supported**.

---

## 💡 Practical Tip

A common setup:

* 1× YubiKey (daily use)
* 1× backup YubiKey
* 1× offline (manual) key stored securely

This gives you redundancy without relying on a single hardware token.

---

If you want, I can also extend this with:

* a **full backup/restore workflow**
* or a **hybrid PQ + YubiKey strategy** (which is where things get interesting right now)
