;; Institution Verification Contract
;; Verifies and maintains registry of authorized research institutions

(define-data-var admin principal tx-sender)

;; Institutional status map
(define-map institutions
  { institution-id: (string-ascii 64) }
  {
    name: (string-ascii 100),
    status: (string-ascii 20),
    verification-date: uint,
    address: principal
  }
)

;; Public function to register a new institution (admin only)
(define-public (register-institution
  (institution-id (string-ascii 64))
  (name (string-ascii 100))
  (address principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1001))
    (asserts! (is-none (map-get? institutions {institution-id: institution-id})) (err u1002))
    (ok (map-insert institutions
      {institution-id: institution-id}
      {
        name: name,
        status: "verified",
        verification-date: block-height,
        address: address
      }
    ))
  )
)

;; Public function to revoke institution verification
(define-public (revoke-verification (institution-id (string-ascii 64)))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1003))
    (asserts! (is-some (map-get? institutions {institution-id: institution-id})) (err u1004))
    (ok (map-set institutions
      {institution-id: institution-id}
      (merge (unwrap-panic (map-get? institutions {institution-id: institution-id}))
        {status: "revoked"}
      )
    ))
  )
)

;; Read-only function to check if an institution is verified
(define-read-only (is-verified (institution-id (string-ascii 64)))
  (match (map-get? institutions {institution-id: institution-id})
    institution (is-eq (get status institution) "verified")
    false
  )
)

;; Read-only function to get institution details
(define-read-only (get-institution (institution-id (string-ascii 64)))
  (map-get? institutions {institution-id: institution-id})
)

;; Transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1005))
    (ok (var-set admin new-admin))
  )
)
