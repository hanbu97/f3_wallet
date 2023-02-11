use anyhow::{anyhow, Result};

use flair_wallet::WalletType;
// use flair_wallet::{FlairPrivate, WalletType};
use flutter_rust_bridge::ZeroCopyBuffer;

//
// NOTE: Please look at https://github.com/fzyzcjy/flutter_rust_bridge/blob/master/frb_example/simple/rust/src/api.rs
// to see more types that this code generator can generate.
//

pub fn draw_mandelbrot(
    image_size: Size,
    zoom_point: Point,
    scale: f64,
    num_threads: i32,
) -> Result<ZeroCopyBuffer<Vec<u8>>> {
    // Just an example that generates "complicated" images ;)
    let image = crate::off_topic_code::mandelbrot(image_size, zoom_point, scale, num_threads)?;
    Ok(ZeroCopyBuffer(image))
}

pub fn passing_complex_structs(root: TreeNode) -> String {
    format!(
        "Hi this string is from Rust. I received a complex struct: {:?}",
        root
    )
}

pub fn returning_structs_with_boxed_fields() -> BoxedPoint {
    BoxedPoint {
        point: Box::new(Point { x: 0.0, y: 0.0 }),
    }
}

#[derive(Debug, Clone)]
pub struct Size {
    pub width: i32,
    pub height: i32,
}

#[derive(Debug, Clone)]
pub struct Point {
    pub x: f64,
    pub y: f64,
}

#[derive(Debug, Clone)]
pub struct TreeNode {
    pub name: String,
    pub children: Vec<TreeNode>,
}

#[derive(Debug, Clone)]
pub struct BoxedPoint {
    pub point: Box<Point>,
}

// following are used only for memory tests. Readers of this example do not need to consider it.

pub fn off_topic_memory_test_input_array(input: Vec<u8>) -> i32 {
    input.len() as i32
}

pub fn off_topic_memory_test_output_zero_copy_buffer(len: i32) -> ZeroCopyBuffer<Vec<u8>> {
    ZeroCopyBuffer(vec![0u8; len as usize])
}

pub fn off_topic_memory_test_output_vec_u8(len: i32) -> Vec<u8> {
    vec![0u8; len as usize]
}

pub fn off_topic_memory_test_input_vec_of_object(input: Vec<Size>) -> i32 {
    input.len() as i32
}

pub fn off_topic_memory_test_output_vec_of_object(len: i32) -> Vec<Size> {
    let item = Size {
        width: 42,
        height: 42,
    };
    vec![item; len as usize]
}

pub fn off_topic_memory_test_input_complex_struct(input: TreeNode) -> i32 {
    input.children.len() as i32
}

pub fn off_topic_memory_test_output_complex_struct(len: i32) -> TreeNode {
    let child = TreeNode {
        name: "child".to_string(),
        children: Vec::new(),
    };
    TreeNode {
        name: "root".to_string(),
        children: vec![child; len as usize],
    }
}

pub fn off_topic_deliberately_return_error() -> Result<i32> {
    #[cfg(not(target_family = "wasm"))]
    std::env::set_var("RUST_BACKTRACE", "1"); // optional, just to see more info...
    Err(anyhow!("deliberately return Error!"))
}

pub fn off_topic_deliberately_panic() -> i32 {
    #[cfg(not(target_family = "wasm"))]
    std::env::set_var("RUST_BACKTRACE", "1"); // optional, just to see more info...
    panic!("deliberately panic!")
}

// wallet_type: 0 -> scep
// wallet_type: 1 -> bls
pub fn generate_address_from_private_key(input: String) -> String {
    let res = flair_wallet::FlairAccount::import(&input);
    let address = match res {
        Ok(t) => t.display(),
        Err(_) => "".to_string(),
    };
    address
}

// msg: message cid
// private_key: private key
// wallet_type: 1 -> scep
// wallet_type: 2 -> bls
pub fn sign_message_with_private_key(msg: String, private_key: String) -> [String; 2] {
    let res = flair_wallet::FlairAccount::import(&private_key);
    match res {
        Ok(account) => {
            let sig = account.sign(msg);
            match sig {
                Ok(t) => {
                    let wallet_type = account.get_type();
                    match wallet_type {
                        WalletType::Secp256k1 => [t, 1.to_string()],
                        WalletType::Bls => [t, 2.to_string()],
                    }
                }
                Err(_) => ["".to_string(), 0.to_string()],
            }
        }
        Err(_) => ["".to_string(), 0.to_string()],
    }
}

pub fn create_multisig_params(
    addresses: Vec<String>,
    threshold: u64,
    unlock_duration: i64,
    start_epoch: i64,
) -> String {
    flair_wallet::create_multisig_params(addresses, threshold, unlock_duration, start_epoch)
}

pub fn multisig_send_propose_params(to: String, value: String) -> String {
    flair_wallet::multisig_send_propose_params(to, value)
}

pub fn multisig_approve_params(txnid: i64) -> String {
    flair_wallet::multisig_approve_params(txnid)
}

#[allow(clippy::too_many_arguments)]
pub fn message_cid(
    from: String,
    to: String,
    nonce: u64,
    value: String,
    method: u64,
    params: String,
    gas_limit: i64,
    gas_fee_cap: String,
    gas_premium: String,
) -> String {
    flair_wallet::message_cid(
        from,
        to,
        nonce,
        value,
        method,
        params,
        gas_limit,
        gas_fee_cap,
        gas_premium,
    )
}

#[test]
fn test_sign_message_with_private_key() {
    let msg = "bafy2bzaceboh7ft42odw5vgqqljp7rxg6ycsf4ye5bcgpn3ytiduklprnnpqk".to_string();
    let private_key = "7b2254797065223a22626c73222c22507269766174654b6579223a2270657341657756666d382f6f7a574c736b6f767a7464677a62566d73677657695a70506f346d53367269493d227d".to_string();

    let sig = sign_message_with_private_key(msg, private_key);
    dbg!(sig);
}

#[test]
fn test_generate_address_from_private_key() {
    let t = generate_address_from_private_key( "7b2254797065223a22736563703235366b31222c22507269766174654b6579223a2235734d384f2b6639554161686d78726d61653533776a667056374338664b6b426c414c4c44366e717a666b3d227d".to_string());
    dbg!(t);
    let t = "7b2254797065223a22626c73222c22507269766174654b6579223a226b434b523969566b73615a6672746b513979356e3269615862317279766d314d37637357456352313142673d227d".to_string();
    let t = generate_address_from_private_key(t);
    dbg!(t);
}

#[test]
fn test_create_multisig_params() {
    let addresses = vec![
        "t3quwa4vrjyk77zqbpeball2xlemlezcdfolexqki4ialamvql7eap2u6ryzc4ufzeuyplti5ruopbtansv63q"
            .to_string(),
        "t3qyqntzkarnpzg66gcgotopmducfqfvvhg7ee7l6ral5xbzimhf5qrduufsxemulrb2zfjdmpdvftaljzuhva"
            .to_string(),
        "t3sh7bfopxlxpaxhbrytc54qqwaeuytzlpfy36iuxjknjvm3ycj7ewajbnervggfoqwk4xhjdpvk54bpiesaya"
            .to_string(),
    ];
    let cbor = create_multisig_params(addresses, 2, 0, 0);
    assert_eq!(
        r#"gtgqWCcAAVWg5AIgvGYj9BUVHYVe+BQL2aZx7bXI23BqMGTsKceSrVLKtzNYnoSDWDEDhSwOVinCv/zALyBAterrIxZMiGVyyXgpHEAWBlYL+QD9U9HGRcoXJKYeuaOxo54ZWDEDhiDZ5UCLX5N7xhGdNz2DoIsC1qc3yE+v0QL7cOUMOXsIjpQsrkZRcQ6yVI2PHUswWDEDkf4Sufdd3gucMcTF3kIWASmJ5W8uN+RS6VNTVm8CT8lgJC0kamMV0LK5c6RvqrvAAgAA"#,
        &cbor
    );
}

#[test]
fn test_multisig_send_propose_params() {
    let cbor = multisig_send_propose_params(
        "t1jkzcn2xstealyngt123llhdjmeygrp6b5amvzhvklbi".to_string(),
        "10000000000000000000".to_string(),
    );
    assert_eq!(r#"hFUBSrIm6vKZALw0y1nGlhMGi/wegZVJAIrHIwSJ6AAAAEA="#, &cbor);
}

// bafy2bzacedagvaxsjeske35wjpx3wtu7mopbdtiovbxz2aksji2haf4f2aq4g
#[test]
fn test_message_cid_generate() {
    let cid = message_cid(
        "f3quwa4vrjyk77zqbpeball2xlemlezcdfolexqki4ialamvql7eap2u6ryzc4ufzeuyplti5ruopbtansv63q"
            .to_string(),
        "t01".to_string(),
        111,
        "0".to_string(),
        2,
        "gtgqWCcAAVWg5AIgvGYj9BUVHYVe+BQL2aZx7bXI23BqMGTsKceSrVLKtzNYa4SCWDEDhSwOVinCv/zALyBAterrIxZMiGVyyXgpHEAWBlYL+QD9U9HGRcoXJKYeuaOxo54ZWDEDhiDZ5UCLX5N7xhGdNz2DoIsC1qc3yE+v0QL7cOUMOXsIjpQsrkZRcQ6yVI2PHUswAgAA".to_string(),
        15851776,
        "101265".to_string(),
        "100211".to_string());
    dbg!(&cid);
    assert_eq!(
        "bafy2bzacedagvaxsjeske35wjpx3wtu7mopbdtiovbxz2aksji2haf4f2aq4g",
        cid
    )
}
// 0,
// 1,
// 2,
// 3,
// 4,
// 8,
// 8,
// 8,
// 0,
// 18,
// 52,
