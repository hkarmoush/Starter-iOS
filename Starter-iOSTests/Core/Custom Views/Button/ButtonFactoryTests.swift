//
//  ButtonFactoryTests.swift
//  Starter-iOSTests
//
//  Created by Hasan Armoush on 02/11/2023.
//

import XCTest
@testable import Starter_iOS

class ButtonFactoryTests: XCTestCase {

    // Test creating a button with default style
    func testButtonCreationWithDefaultStyle() {
        // Given
        let style = ButtonConfiguration(
            title: "Test",
            titleColor: .black,
            font: UIFont.systemFont(ofSize: 15),
            backgroundColor: .white,
            cornerRadius: 5
        )
        
        // When
        let button = ButtonFactory.create(with: style)
        
        // Then
        XCTAssertEqual(button.title(for: .normal), "Test")
        XCTAssertEqual(button.titleColor(for: .normal), .black)
        XCTAssertEqual(button.titleLabel?.font, UIFont.systemFont(ofSize: 15))
        XCTAssertEqual(button.backgroundColor, .white)
        XCTAssertEqual(button.layer.cornerRadius, 5)
        XCTAssertNil(button.layer.borderColor)
        XCTAssertEqual(button.layer.borderWidth, 0)
    }

    // Test creating a button with border style
    func testButtonCreationWithBorderStyle() {
        // Given
        let borderStyle = ButtonConfiguration.Border(color: .red, width: 2)
        var style = ButtonConfiguration(
            title: "Test Border",
            titleColor: .black,
            font: UIFont.systemFont(ofSize: 15),
            backgroundColor: .white,
            cornerRadius: 5
        )
        style.border = borderStyle
        
        // When
        let button = ButtonFactory.create(with: style)
        
        // Then
        XCTAssertEqual(button.layer.borderColor, UIColor.red.cgColor)
        XCTAssertEqual(button.layer.borderWidth, 2)
    }

    // Test creating a button with shadow style
    func testButtonCreationWithShadowStyle() {
        // Given
        let shadowStyle = ButtonConfiguration.Shadow(color: .black, offset: CGSize(width: 1, height: 1), opacity: 0.5, radius: 3)
        var style = ButtonConfiguration(
            title: "Test Shadow",
            titleColor: .black,
            font: UIFont.systemFont(ofSize: 15),
            backgroundColor: .white,
            cornerRadius: 5
        )
        style.shadow = shadowStyle
        
        // When
        let button = ButtonFactory.create(with: style)
        
        // Then
        XCTAssertEqual(button.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(button.layer.shadowOffset, CGSize(width: 1, height: 1))
        XCTAssertEqual(button.layer.shadowOpacity, 0.5)
        XCTAssertEqual(button.layer.shadowRadius, 3)
    }

    // Test creating a button with gradient style
    func testButtonCreationWithGradientStyle() {
        // Given
        let gradientColors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        let gradientLocations: [NSNumber] = [0, 1]
        let gradientStyle = ButtonConfiguration.Gradient(colors: gradientColors, locations: gradientLocations)
        var style = ButtonConfiguration(
            title: "Test Gradient",
            titleColor: .black,
            font: UIFont.systemFont(ofSize: 15),
            backgroundColor: .white,
            cornerRadius: 5
        )
        style.gradient = gradientStyle
        
        // When
        let button = ButtonFactory.create(with: style)
        let gradientLayer = button.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first
        
        // Then
        XCTAssertEqual(gradientLayer?.colors as? [CGColor], gradientColors)
        XCTAssertEqual(gradientLayer?.locations, gradientLocations)
        XCTAssertEqual(gradientLayer?.cornerRadius, 5)
    }
}
