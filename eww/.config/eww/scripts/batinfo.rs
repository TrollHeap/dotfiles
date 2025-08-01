use std::fs;

// ---- Helper: Lire un fichier sysfs et retourner l'entier, sinon 0
fn read_value<P: AsRef<std::path::Path>>(path: P) -> i64 {
    fs::read_to_string(path)
        .ok()
        .and_then(|s| s.trim().parse::<i64>().ok())
        .unwrap_or(0)
}

// ---- Génération icône + classe unicode
fn icon_for(capacity: i64, charging: bool) -> (&'static str, &'static str) {
    if charging {
        return ("CHARGING", "");
    }
    match capacity {
        90..=100 => ("BAT1", " "),
        65..=89 => ("BAT2", " "),
        45..=64 => ("BAT3", " "),
        15..=44 => ("BAT4", " "),
        _ => ("BAT5", " "),
    }
}

// ---- Format texte EWW (mode détail ou simple)
fn eww_battery_box(capacity: i64, icon_class: &str, icon: &str) -> String {
    format!(
        "(box :class \"{}\" \"{}\" (label :text \"{}%\"))",
        icon_class, icon, capacity
    )
}

fn main() {
    // Arguments : détail ou simple (optionnel)
    let args: Vec<String> = std::env::args().collect();
    let detail = args.get(1).map_or(false, |s| s == "--detail");

    // Lire tous les fichiers sysfs nécessaires
    let base = "/sys/class/power_supply/BAT0";
    let capacity = read_value(format!("{}/capacity", base));
    let charge_now = read_value(format!("{}/charge_now", base));
    let charge_full = read_value(format!("{}/charge_full", base));
    let current_now = read_value(format!("{}/current_now", base));
    let status = fs::read_to_string(format!("{}/status", base))
        .unwrap_or_default()
        .trim()
        .to_string();

    let charging = status == "Charging";
    let (icon_class, icon) = icon_for(capacity, charging);

    // Format pour EWW
    let output = eww_battery_box(capacity, icon_class, icon);

    if !std::path::Path::new("/sys/class/power_supply/BAT0").exists() {
        std::process::exit(0);
    }
    // Sortie “box” pour EWW (toujours)
    println!("{}", output);

    // Si mode détail, affiche ETA (tu peux supprimer ce bloc si tu ne veux jamais l'utiliser)
    if detail {
        if current_now != 0 {
            let eta = if status == "Discharging" {
                let mins = (charge_now * 60) / current_now;
                format!("{} h {} min left, {}", mins / 60, mins % 60, status)
            } else if status == "Charging" {
                let diff = charge_full - charge_now;
                let mins = (diff * 60) / current_now;
                format!("{} h {} min to full, {}", mins / 60, mins % 60, status)
            } else {
                format!("0 h 0 min to full, {}", status)
            };
            println!("{}", eta);
        }
    }
}
