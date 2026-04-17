# Fix: "Unusable public key" error in GPG

## Error message

If you encounter the following error, it usually means that no trusted public key is available:

```bash
There is no assurance this key belongs to the named user
encryption failed: Unusable public key
```

## Cause

GPG refuses to encrypt because the public key is not trusted.

## Solution

You need to mark the public key as trusted.

### Step 1: List available keys

```bash
gpg --list-keys
```

Example output:

```bash
pub   ed25519 2026-04-09 [C]
      ABCDEFGHIJKLMNOPQRSTUVWXYX1234
uid           [ultimate] John Doe <John.Doe@domain.tld>
```

### Step 2: Edit the key

Use the email address (or key ID) from the `uid` line:

```bash
gpg --edit-key John.Doe@domain.tld
```

### Step 3: Set trust level

Inside the GPG prompt, run:

```text
trust
5
y
quit
```

### Step 4: Verify

After setting the trust level, GPG should be able to encrypt without errors.

---

## Notes

* Trust level `5` means "ultimate trust" and is appropriate for your own keys.
* You can also use the key fingerprint instead of the email address for more precise identification.
* Make sure the key has an encryption subkey (`[E]`) if you are using it with tools like `pass`.

