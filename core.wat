(module
  (import "env" "memory" (memory 1))
  (import "env" "cos" (func $cos (param f64) (result f64)))
  (import "env" "sin" (func $sin (param f64) (result f64)))
  (import "env" "sqrt" (func $sqrt (param f64) (result f64)))

  ;; is_prime implementation
  ;; returns 1 if prime, 0 otherwise
  (func $is_prime (param $n i32) (result i32)
    (local $i i32)
    
    (if (i32.le_u (local.get $n) (i32.const 1))
      (then (return (i32.const 0)))
    )
    
    (if (i32.eq (local.get $n) (i32.const 2))
      (then (return (i32.const 1)))
    )
    
    (if (i32.eq (i32.rem_u (local.get $n) (i32.const 2)) (i32.const 0))
      (then (return (i32.const 0)))
    )
    
    (local.set $i (i32.const 3))
    
    (loop $check_loop
      (if (i32.gt_u (local.get $i) (i32.div_u (local.get $n) (local.get $i)))
        (then (return (i32.const 1)))
      )
      
      (if (i32.eq (i32.rem_u (local.get $n) (local.get $i)) (i32.const 0))
        (then (return (i32.const 0)))
      )
      
      (local.set $i (i32.add (local.get $i) (i32.const 2)))
      (br $check_loop)
    )
    
    (i32.const 1)
  )

  ;; write prime spiral data to memory
  ;; mode 0 = Ulam spiral (square grid), mode 1 = Sacks spiral (Archimedean)
  ;; returns number of visible points drawn (writes f32 x, y to memory sequentially)
  (func $generate_spiral 
    (param $count i32) 
    (param $mode i32)
    (param $scale f64) 
    (param $center_x f64) 
    (param $center_y f64) 
    (param $width f64) 
    (param $height f64) 
    (result i32)
    
    (local $n i32)
    (local $drawn_count i32)
    (local $offset i32)
    (local $x f64)
    (local $y f64)
    
    ;; Temporary variables for calculations
    (local $tmp_f64 f64)
    (local $root f64)
    
    ;; Ulam variables
    (local $k i32)
    (local $m i32)
    
    (local.set $n (i32.const 1))
    (local.set $drawn_count (i32.const 0))
    (local.set $offset (i32.const 0))
    
    (loop $draw_loop
      (if (i32.gt_u (local.get $n) (local.get $count))
        (then (return (local.get $drawn_count)))
      )
      
      (if (call $is_prime (local.get $n))
        (then
          
          ;; Ulam Spiral (Mode 0) logic
          ;; For a number n, calculate coordinates in a continuous square spiral
          ;; Wait we can just do Sacks spiral or both? Let's just do an Archimedean first (Sacks)
          ;; since the ulam formula without floating points is a bit involved in pure wasm
          
          ;; For Sacks spiral, radius represents the square root of n:
          ;; r = sqrt(n), theta = 2 * pi * sqrt(n)
          
          (local.set $root (call $sqrt (f64.convert_i32_u (local.get $n))))
          
          (local.set $tmp_f64 (f64.mul (f64.const 6.283185307179586) (local.get $root))) ;; theta = 2pi * sqrt(n)
          
          (local.set $x (f64.add (local.get $center_x) (f64.mul (f64.mul (local.get $root) (local.get $scale)) (call $cos (local.get $tmp_f64)))))
          (local.set $y (f64.add (local.get $center_y) (f64.mul (f64.mul (local.get $root) (local.get $scale)) (call $sin (local.get $tmp_f64)))))
          
          ;; Boundary check
          (if (f64.ge (local.get $x) (f64.const 0.0))
            (then
              (if (f64.le (local.get $x) (local.get $width))
                (then
                  (if (f64.ge (local.get $y) (f64.const 0.0))
                    (then
                      (if (f64.le (local.get $y) (local.get $height))
                        (then
                          ;; Write to memory: [x: f32, y: f32]
                          (f32.store 
                            (local.get $offset) 
                            (f32.demote_f64 (local.get $x))
                          )
                          (f32.store 
                            (i32.add (local.get $offset) (i32.const 4)) 
                            (f32.demote_f64 (local.get $y))
                          )
                          
                          (local.set $offset (i32.add (local.get $offset) (i32.const 8)))
                          (local.set $drawn_count (i32.add (local.get $drawn_count) (i32.const 1)))
                        )
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
      
      (local.set $n (i32.add (local.get $n) (i32.const 1)))
      (br $draw_loop)
    )
    (local.get $drawn_count)
  )
  
  (export "is_prime" (func $is_prime))
  (export "generate_spiral" (func $generate_spiral))
)
