``` mermaid
erDiagram
    Users ||--o{ Scores : achieves
    
    Users {
        Integer id
        String name
        String username
    }

    Scores {
        Integer user_id
        Datetime    datetime
        Integer score
    }

```