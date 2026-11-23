import { useEffect, useState } from 'react'

type Health = { status: string }

const API_URL = import.meta.env.VITE_API_URL

export default function App() {
  const [health, setHealth] = useState<Health | null>(null)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    fetch(`${API_URL}/health`)
      .then((res) => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`)
        return res.json() as Promise<Health>
      })
      .then(setHealth)
      .catch((err: unknown) => {
        setError(err instanceof Error ? err.message : String(err))
      })
  }, [])

  return (
    <main style={{ fontFamily: 'system-ui', padding: '2rem' }}>
      <h1>Proviso</h1>
      {error && <p>API unreachable: {error}</p>}
      {!error && !health && <p>Checking API…</p>}
      {health && <p>API status: {health.status}</p>}
    </main>
  )
}