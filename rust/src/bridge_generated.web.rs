use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_draw_mandelbrot(
    port_: MessagePort,
    image_size: JsValue,
    zoom_point: JsValue,
    scale: f64,
    num_threads: i32,
) {
    wire_draw_mandelbrot_impl(port_, image_size, zoom_point, scale, num_threads)
}

#[wasm_bindgen]
pub fn wire_passing_complex_structs(port_: MessagePort, root: JsValue) {
    wire_passing_complex_structs_impl(port_, root)
}

#[wasm_bindgen]
pub fn wire_returning_structs_with_boxed_fields(port_: MessagePort) {
    wire_returning_structs_with_boxed_fields_impl(port_)
}

#[wasm_bindgen]
pub fn wire_off_topic_memory_test_input_array(port_: MessagePort, input: Box<[u8]>) {
    wire_off_topic_memory_test_input_array_impl(port_, input)
}

#[wasm_bindgen]
pub fn wire_off_topic_memory_test_output_zero_copy_buffer(port_: MessagePort, len: i32) {
    wire_off_topic_memory_test_output_zero_copy_buffer_impl(port_, len)
}

#[wasm_bindgen]
pub fn wire_off_topic_memory_test_output_vec_u8(port_: MessagePort, len: i32) {
    wire_off_topic_memory_test_output_vec_u8_impl(port_, len)
}

#[wasm_bindgen]
pub fn wire_off_topic_memory_test_input_vec_of_object(port_: MessagePort, input: JsValue) {
    wire_off_topic_memory_test_input_vec_of_object_impl(port_, input)
}

#[wasm_bindgen]
pub fn wire_off_topic_memory_test_output_vec_of_object(port_: MessagePort, len: i32) {
    wire_off_topic_memory_test_output_vec_of_object_impl(port_, len)
}

#[wasm_bindgen]
pub fn wire_off_topic_memory_test_input_complex_struct(port_: MessagePort, input: JsValue) {
    wire_off_topic_memory_test_input_complex_struct_impl(port_, input)
}

#[wasm_bindgen]
pub fn wire_off_topic_memory_test_output_complex_struct(port_: MessagePort, len: i32) {
    wire_off_topic_memory_test_output_complex_struct_impl(port_, len)
}

#[wasm_bindgen]
pub fn wire_off_topic_deliberately_return_error(port_: MessagePort) {
    wire_off_topic_deliberately_return_error_impl(port_)
}

#[wasm_bindgen]
pub fn wire_off_topic_deliberately_panic(port_: MessagePort) {
    wire_off_topic_deliberately_panic_impl(port_)
}

#[wasm_bindgen]
pub fn wire_generate_address_from_private_key(port_: MessagePort, input: String) {
    wire_generate_address_from_private_key_impl(port_, input)
}

#[wasm_bindgen]
pub fn wire_sign_message_with_private_key(port_: MessagePort, msg: String, private_key: String) {
    wire_sign_message_with_private_key_impl(port_, msg, private_key)
}

#[wasm_bindgen]
pub fn wire_create_multisig_params(
    port_: MessagePort,
    addresses: JsValue,
    threshold: u64,
    unlock_duration: i64,
    start_epoch: i64,
) {
    wire_create_multisig_params_impl(port_, addresses, threshold, unlock_duration, start_epoch)
}

#[wasm_bindgen]
pub fn wire_multisig_send_propose_params(port_: MessagePort, to: String, value: String) {
    wire_multisig_send_propose_params_impl(port_, to, value)
}

#[wasm_bindgen]
pub fn wire_multisig_approve_params(port_: MessagePort, txnid: i64) {
    wire_multisig_approve_params_impl(port_, txnid)
}

#[wasm_bindgen]
pub fn wire_message_cid(
    port_: MessagePort,
    from: String,
    to: String,
    nonce: u64,
    value: String,
    method: u64,
    params: String,
    gas_limit: i64,
    gas_fee_cap: String,
    gas_premium: String,
) {
    wire_message_cid_impl(
        port_,
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

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}
impl Wire2Api<Vec<String>> for JsValue {
    fn wire2api(self) -> Vec<String> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}

impl Wire2Api<Vec<Size>> for JsValue {
    fn wire2api(self) -> Vec<Size> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}
impl Wire2Api<Vec<TreeNode>> for JsValue {
    fn wire2api(self) -> Vec<TreeNode> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}
impl Wire2Api<Point> for JsValue {
    fn wire2api(self) -> Point {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        Point {
            x: self_.get(0).wire2api(),
            y: self_.get(1).wire2api(),
        }
    }
}
impl Wire2Api<Size> for JsValue {
    fn wire2api(self) -> Size {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        Size {
            width: self_.get(0).wire2api(),
            height: self_.get(1).wire2api(),
        }
    }
}
impl Wire2Api<TreeNode> for JsValue {
    fn wire2api(self) -> TreeNode {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        TreeNode {
            name: self_.get(0).wire2api(),
            children: self_.get(1).wire2api(),
        }
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}
// Section: impl Wire2Api for JsValue

impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<f64> for JsValue {
    fn wire2api(self) -> f64 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<i32> for JsValue {
    fn wire2api(self) -> i32 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<i64> for JsValue {
    fn wire2api(self) -> i64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<u64> for JsValue {
    fn wire2api(self) -> u64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<u8> for JsValue {
    fn wire2api(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Vec<u8>> for JsValue {
    fn wire2api(self) -> Vec<u8> {
        self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
    }
}
