import { useState, useEffect } from 'react'

export const useHasmounted = () => {
   const [hasMounted, setHasMounted] = useState<boolean>(false)
   useEffect(() => {
      setHasMounted(true)
   }, [])

   return hasMounted
}
