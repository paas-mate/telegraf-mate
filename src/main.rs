use std::env;
use std::process::Command;

fn main() {
    let result = env::var("TELEGRAF_HOME").unwrap();
    let script_path = result + "/mate/scripts/start-telegraf.sh";
    let fail_msg = "failed to execute process";
    let output = Command::new("/bin/bash")
        .arg(script_path)
        .output()
        .expect(fail_msg);

    println!("status: {}", output.status);
    println!("stdout: {}", String::from_utf8_lossy(&output.stdout));
    println!("stderr: {}", String::from_utf8_lossy(&output.stderr));

    assert!(output.status.success());
}
