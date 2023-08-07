``` mermaid
erDiagram
    Users ||--o{ Scores : achieves
    
    Users {
        Integer     id
        String      name
        String      username
        Timestamp   created_at
        Timestamp   updated_at
    }

    Scores {
        Integer     user_id
        Integer     score
        Timestamp   created_at
        Timestamp   updated_at
    }

```