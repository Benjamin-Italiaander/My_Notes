---

title: "YubiKey install ykman from git"
draft: false
date: 2020
description: "Installing the Latest ykman Advanced Methods"

---



## 🔧 Installing the Latest `ykman` (Advanced Methods)

For advanced users, there are several ways to install the **latest development version** of YubiKey Manager (`ykman`) directly from source.
Choose the method that best fits your workflow.

---

# 1. 📦 Install `ykman` in a Python Virtual Environment (Recommended)

This keeps the installation **isolated** from your system Python and avoids conflicts.

### 1. Clone the repository

```bash
git clone https://github.com/Yubico/yubikey-manager.git
cd yubikey-manager
```

### 2. Create and activate a virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install `ykman` inside the venv

```bash
pip install .
```

### 4. Test it

```bash
ykman -v
```

> **Tip:** To use `ykman` outside the directory, add `.venv/bin` to your PATH or call it with the full path:
>
> ```
> ~/.venv/bin/ykman
> ```

---

# 2. 🌍 System-Wide Installation (using pip)

This installs `ykman` **directly into your system Python**, replacing the distribution package.

⚠️ **Warning:** This can conflict with distro packages.
Use only if you know what you're doing.

### Commands

```bash
git clone https://github.com/Yubico/yubikey-manager.git
cd yubikey-manager
pip install ./ --break-system-packages
```

### Verify

```bash
ykman -v
```

---

# 3. 🧪 Install `ykman` Using `pipx` (Clean & Isolated)

`pipx` installs Python tools in a **sandboxed environment**, system-wide but isolated from other packages.
This is an excellent method for command-line tools.

### 1. Install pipx (if needed)

```bash
sudo apt install pipx
pipx ensurepath
```

Or manually:

```bash
python3 -m pip install --user pipx
python3 -m pipx ensurepath
```

### 2. Clone the repository

```bash
git clone https://github.com/Yubico/yubikey-manager.git
cd yubikey-manager
```

### 3. Install via pipx

```bash
pipx install .
```

### 4. Test

```bash
ykman -v
```

> **Tip:** To update later:
>
> ```bash
> pipx upgrade yubikey-manager
> ```

---

# ✔️ Summary of Installation Methods

| Method                      | Isolation | System Impact           | Difficulty | Recommended For |
| --------------------------- | --------- | ----------------------- | ---------- | --------------- |
| **Virtual Environment**     | High      | None                    | Easy       | Most users      |
| **System-Wide pip Install** | Low       | Overwrites system files | Medium     | Experts only    |
| **pipx Install**            | High      | None                    | Easy       | CLI tool users  |

