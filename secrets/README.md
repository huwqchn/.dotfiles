# Secrets Management

## Adding or Updating Secrets

1. To use agenix temporarily, run: `nix shell github:yaxitect/ragenix#ragenix`

2. Edit `secrets.nix`: see `./secrets.nix` for an example.

3. Create and edit the secrets file `xxx.age` interactively:
   `sudo agenix -e ./xxx.age -i /etc/ssh/ssh_host_ed25519_key --editor nvim` Alternatively, you can
   encrypt an existing file to `xxx.age` using the following command:
   `cat xxx | sudo agenix  -e ./xxx.age -i /etc/ssh/ssh_host_ed25519_key --editor nvim` agenix will
   encrypt the file with all the public keys we defined in secrets.nix, so all users and systems
   defined in secrets.nix can decrypt it with their private keys.

## Deploying Secrets

see `./default.nix` for an example. From now on, every time you run `nixos-rebuild` switch, it will
decrypt the secrets using the private keys defined in `age.identityPaths`. It will then symlink the
secrets to the path defined by the `age.secrets.<name>.path` argument, which defaults to
`/etc/secrets`.

## Adding a new host

1. `cat` the system-level public key (e.g. `/etc/ssh/ssh_host_ed25519_key.pub`) of the new host, and
   send it to an old host which has already been configured with the secrets.
2. On the old host:

- Add the public key to `secrets.nix`, and rekey all the secrets via
  `sudo agenix -r -i /etc/ssh/ssh_host_ed25519_key`.
- Commit and push the changes

3. On the new host:

- Clone this repo, and run `nixos-rebuild switch` to deploy it, all the secrets will be decrypted
  automatically via the host private key.
