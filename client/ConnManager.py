#!/usr/bin/env python3

import sys
from ConnSettings import *
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit, QPushButton

class MainPage(QWidget):
    def __init__(self):
        super().__init__()
        # Set window title and size
        self.setWindowTitle(MAIN_WINDOW_TITLE)
        self.resize(WINDOW_WIDTH, WINDOW_HEIGHT)
        
        # Create widgets for each page
        self.config_label = QLabel(CONFIG_LABEL_TEXT)
        self.config_button = QPushButton(CONFIG_BUTTON_TEXT)
        self.summary_label = QLabel(SUMMARY_LABEL_TEXT)
        self.summary_button = QPushButton(SUMMARY_BUTTON_TEXT)
        self.connect_label = QLabel(CONNECT_LABEL_TEXT)
        self.connect_button = QPushButton(CONNECT_BUTTON_TEXT)
        
        # Create layout for main page
        main_layout = QVBoxLayout()
        main_layout.addWidget(self.config_label)
        main_layout.addWidget(self.config_button)
        main_layout.addWidget(self.summary_label)
        main_layout.addWidget(self.summary_button)
        main_layout.addWidget(self.connect_label)
        main_layout.addWidget(self.connect_button)
        self.setLayout(main_layout)
        
        # Connect buttons to subpages
        self.config_button.clicked.connect(self.show_config)
        self.summary_button.clicked.connect(self.show_summary)
        self.connect_button.clicked.connect(self.show_connect)
        
    def show_config(self):
        self.config_window = ConfigPage()
        self.config_window.show()
        self.hide()
    
    def show_summary(self):
        self.summary_window = SummaryPage()
        self.summary_window.show()
        self.hide()
    
    def show_connect(self):
        self.connect_window = ConnectPage()
        self.connect_window.show()
        self.hide()

class ConfigPage(QWidget):
    def __init__(self):
        super().__init__()
        
        # Set window title and size
        self.setWindowTitle(CONFIG_WINDOW_TITLE)
        self.resize(WINDOW_WIDTH, WINDOW_HEIGHT)
        
        # Create widgets for network summary page
        self.config_label = QLabel(CONFIG_LABEL_TEXT)
        self.back_button = QPushButton("Back")
        self.back_button.clicked.connect(self.show_main_page)
        
        # Create layout for network summary page
        config_layout = QVBoxLayout()
        config_layout.addWidget(self.config_label)
        
        # Add "back" button to the layout
        button_layout = QHBoxLayout()
        button_layout.addStretch()
        button_layout.addWidget(self.back_button)
        config_layout.addLayout(button_layout)
        
        self.setLayout(config_layout)

    def show_main_page(self):
        self.main_window = MainPage()
        self.main_window.show()
        self.hide()
        
class SummaryPage(QWidget):
    def __init__(self):
        super().__init__()
        
        # Set window title and size
        self.setWindowTitle(SUMMARY_WINDOW_TITLE)
        self.resize(WINDOW_WIDTH, WINDOW_HEIGHT)
        
        # Create widgets for network summary page
        self.summary_label = QLabel(SUMMARY_LABEL_TEXT)
        self.back_button = QPushButton("Back")
        self.back_button.clicked.connect(self.show_main_page)
        
        # Create layout for network summary page
        summary_layout = QVBoxLayout()
        summary_layout.addWidget(self.summary_label)
        
        # Add "back" button to the layout
        button_layout = QHBoxLayout()
        button_layout.addStretch()
        button_layout.addWidget(self.back_button)
        summary_layout.addLayout(button_layout)
        
        self.setLayout(summary_layout)

    def show_main_page(self):
        self.main_window = MainPage()
        self.main_window.show()
        self.hide()

        
class ConnectPage(QWidget):
    def __init__(self):
        super().__init__()
        
        # Set window title and size
        self.setWindowTitle(CONNECT_WINDOW_TITLE)
        self.resize(WINDOW_WIDTH, WINDOW_HEIGHT)
        
        # Create widgets for network summary page
        self.connect_label = QLabel(CONNECT_LABEL_TEXT)
        self.back_button = QPushButton("Back")
        self.back_button.clicked.connect(self.show_main_page)
        
        # Create layout for network connect page
        connect_layout = QVBoxLayout()
        connect_layout.addWidget(self.connect_label)
        
        # Add "back" button to the layout
        button_layout = QHBoxLayout()
        button_layout.addStretch()
        button_layout.addWidget(self.back_button)
        connect_layout.addLayout(button_layout)
        
        self.setLayout(connect_layout)

    def show_main_page(self):
        self.main_window = MainPage()
        self.main_window.show()
        self.hide()

if __name__ == '__main__':
    # Initialize application and main window
    app = QApplication(sys.argv)
    window = MainPage()
    
    # Show main window and start event loop
    window.show()
    sys.exit(app.exec_())

    