#!/usr/bin/env bash
set -euo pipefail

KEY_TYPE=ed25519
KEY_COMMENT="${USER}@$(hostname)-$(date +%Y%m%d)"
SSH_KEY_PATH="$HOME/.ssh/id_${KEY_TYPE}_github"
SSH_CONFIG="$HOME/.ssh/config"

# Génère la clé si absente
if [[ ! -f "$SSH_KEY_PATH" ]]; then
    ssh-keygen -t $KEY_TYPE -C "$KEY_COMMENT" -f "$SSH_KEY_PATH" -N ""
    echo "✅ Clé SSH générée: $SSH_KEY_PATH"
else
    echo "⚠️  Clé SSH déjà existante: $SSH_KEY_PATH"
fi

echo
echo "------ Clé publique à copier dans GitHub ------"
cat "${SSH_KEY_PATH}.pub"
echo "-----------------------------------------------"
echo "Va sur https://github.com/settings/keys et colle la clé affichée ci-dessus."
echo

# Ajoute ou remplace la section Host github.com dans ~/.ssh/config
if grep -q 'Host github.com' "$SSH_CONFIG" 2>/dev/null; then
    # Supprime l'existant (simple, section entière)
    sed -i '/Host github.com/,+4d' "$SSH_CONFIG"
fi

cat <<EOF >>"$SSH_CONFIG"

Host github.com
    HostName github.com
    User git
    IdentityFile $SSH_KEY_PATH
    IdentitiesOnly yes

EOF

echo "✅ Bloc SSH config ajouté/actualisé dans $SSH_CONFIG"
