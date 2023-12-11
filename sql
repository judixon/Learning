// Definiujemy nazwę i typ taska
tasks.register('snowman', DefaultTask) {
    // Dodajemy opis taska
    description = 'Wykonuje komendę SNOWMAN PUT na plikach i katalogach w podanym katalogu'
    // Definiujemy parametr taska, który jest nazwą katalogu
    @Input
    String dirName
    // Definiujemy akcję taska, która będzie wykonywana podczas jego uruchomienia
    doLast {
        // Sprawdzamy, czy podany katalog istnieje
        File dir = file(dirName)
        if (dir.exists() && dir.isDirectory()) {
            // Tworzymy listę plików i katalogów w podanym katalogu
            List<File> files = dir.listFiles().toList()
            // Sortujemy listę alfabetycznie
            files.sort { a, b -> a.name <=> b.name }
            // Iterujemy po liście plików i katalogów
            files.each { file ->
                // Tworzymy ścieżkę do pliku lub katalogu względem podanego katalogu
                String path = file.path - dir.path
                // Wykonujemy komendę SNOWMAN PUT z podaną ścieżką
                exec {
                    commandLine 'SNOWMAN', 'PUT', path
                }
                // Jeśli plik jest katalogiem, używamy zipTree do uzyskania jego zawartości
                if (file.isDirectory()) {
                    // Tworzymy FileTree z zipTree
                    FileTree zip = zipTree(file)
                    // Iterujemy po plikach i katalogach w zipTree
                    zip.each { zipFile ->
                        // Tworzymy ścieżkę do pliku lub katalogu względem podanego katalogu
                        String zipPath = zipFile.path - dir.path
                        // Wykonujemy komendę SNOWMAN PUT z podaną ścieżką
                        exec {
                            commandLine 'SNOWMAN', 'PUT', zipPath
                        }
                    }
                }
            }
        } else {
            // Wypisujemy błąd, jeśli podany katalog nie istnieje lub nie jest katalogiem
            println "Błąd: Podany katalog nie istnieje lub nie jest katalogiem"
        }
    }
}







// Definiujemy nazwę i typ taska
tasks.register('snowman', DefaultTask) {
    // Dodajemy opis taska
    description = 'Wykonuje komendę SNOWMAN PUT na plikach i katalogach w podanym katalogu'
    // Definiujemy parametr taska, który jest nazwą katalogu
    @Input
    String dirName
    // Definiujemy akcję taska, która będzie wykonywana podczas jego uruchomienia
    doLast {
        // Sprawdzamy, czy podany katalog istnieje
        File dir = file(dirName)
        if (dir.exists() && dir.isDirectory()) {
            // Tworzymy listę plików i katalogów w podanym katalogu
            List<File> files = dir.listFiles().toList()
            // Sortujemy listę alfabetycznie
            files.sort { a, b -> a.name <=> b.name }
            // Iterujemy po liście plików i katalogów
            files.each { file ->
                // Tworzymy ścieżkę do pliku lub katalogu względem podanego katalogu
                String path = file.path - dir.path
                // Wykonujemy komendę SNOWMAN PUT z podaną ścieżką
                exec {
                    commandLine 'SNOWMAN', 'PUT', path
                }
            }
        } else {
            // Wypisujemy błąd, jeśli podany katalog nie istnieje lub nie jest katalogiem
            println "Błąd: Podany katalog nie istnieje lub nie jest katalogiem"
        }
    }
}
